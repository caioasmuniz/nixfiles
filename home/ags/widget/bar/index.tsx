import { Variable } from "astal";
import { Astal, App, Gtk } from "astal/gtk3"

import Hyprland from "gi://AstalHyprland";

import SystemIndicators from "./systemIndicators";
import SystemUsage from "./systemUsage";
import Workspaces from "./workspaces";
import Clock from "./clock";

const hyprland = Hyprland.get_default()

const Launcher = () => <button
  css="border-radius:12; padding: 2px;"
  cursor={"pointer"}
  onClicked={() => App.toggle_window("applauncher")}>
  <icon icon="nix-snowflake-symbolic" css="font-size:24px;" />
</button>

const bar = (monitor: Hyprland.Monitor, vertical: boolean) =>
  <window
    margin={0}
    className="Bar"
    application={App}
    monitor={monitor.id}
    name={`bar-${monitor}`}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP |
      Astal.WindowAnchor.LEFT |
      (vertical ?
        Astal.WindowAnchor.BOTTOM :
        Astal.WindowAnchor.RIGHT)}>
    <centerbox
      spacing={6}
      vertical={vertical}
      css={`margin:0px; 
        padding: 2px;
        border-radius:${vertical ?
          "0px 12px 12px 0px" :
          "0px 0px 12px 12px"};
        background: alpha(@theme_bg_color, 0.25);`} >
      <box
        hexpand
        spacing={4}
        vertical={vertical}
        halign={Gtk.Align.START}>
        <Launcher />
        <SystemUsage vertical={vertical} />
        <Workspaces vertical={vertical} monitor={monitor} />
      </box>
      <box spacing={4}>
        <Clock vertical={vertical} />
      </box>
      <box
        hexpand
        spacing={4}
        vertical={vertical}
        valign={vertical ? Gtk.Align.END : Gtk.Align.FILL}
        halign={vertical ? Gtk.Align.FILL : Gtk.Align.END} >
        <SystemIndicators vertical={vertical} />
      </box>
    </centerbox>
  </window>

export default (vertical: Variable<boolean>) => {
  const bars = new Map<Hyprland.Monitor, Gtk.Widget>()

  // initialize
  for (const monitor of hyprland.get_monitors()) {
    bars.set(monitor, bar(monitor, vertical.get()))
  }

  hyprland.connect("monitor-added", (_, monitor) => {
    bars.set(monitor, bar(monitor, vertical.get()))
  })

  hyprland.connect("monitor-removed", (_, monitor) => {
    const hyprMonitor = hyprland.get_monitor(monitor)
    bars.get(hyprMonitor)?.destroy()
    bars.delete(hyprMonitor)
  })

  vertical.subscribe(vert => {
    const monitor = hyprland.focusedMonitor
    bars.get(monitor)?.destroy()
    bars.delete(monitor)
    bars.set(monitor, bar(monitor, vert))
  })
}