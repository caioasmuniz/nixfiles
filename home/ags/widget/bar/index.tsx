import { Astal, App, Gtk } from "astal/gtk3"

import SystemIndicators from "./systemIndicators";
import SystemUsage from "./systemUsage";
import Workspaces from "./workspaces";
import Clock from "./clock";
import Hyprland from "gi://AstalHyprland";

const Launcher = () =>
  <button css="border-radius:12; padding: 2px;"
    cursor={"pointer"}
    onClicked={() => App.toggle_window("applauncher")}>
    <icon icon="nix-snowflake-symbolic" css="font-size:24px;" />
  </button>

export default (monitor: Hyprland.Monitor, vertical: boolean) => <window
  className="Bar" margin={0}
  name={`bar-${monitor}`}
  monitor={monitor.id}
  anchor={Astal.WindowAnchor.TOP |
    Astal.WindowAnchor.LEFT |
    (vertical ?
      Astal.WindowAnchor.BOTTOM :
      Astal.WindowAnchor.RIGHT)}
  exclusivity={Astal.Exclusivity.EXCLUSIVE}
  application={App}>
  <centerbox spacing={6} vertical={vertical}
    css="margin:0px; padding: 2px;
    border-radius:0px 0px 12px 12px;
    background: alpha(@theme_bg_color, 0.25);" >
    <box hexpand halign={Gtk.Align.START}
      vertical={vertical} spacing={4}>
      <Launcher />
      <SystemUsage vertical={vertical} />
      <Workspaces vertical={vertical} monitor={monitor} />
    </box>
    <box spacing={4}>
      <Clock vertical={vertical} />
    </box>
    <box hexpand spacing={4}
      valign={vertical ? Gtk.Align.END : Gtk.Align.FILL}
      halign={vertical ? Gtk.Align.FILL : Gtk.Align.END} >
      <SystemIndicators vertical={vertical} />
    </box>
  </centerbox>
</window>