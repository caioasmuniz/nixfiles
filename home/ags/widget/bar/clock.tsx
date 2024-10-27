import { Variable, GLib } from "astal"
import { Gtk } from "astal/gtk3"

export default ({ vertical }: { vertical: boolean }) => {
  const day = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().get_day_of_month().toString())
  const month = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format("%b")!)
  const hour = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format("%H")!)
  const minute = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format("%M")!)
  return <button className="clock"
    css={`border-radius:12; 
    padding:${vertical ? "2px 0px;" : "0px 4px;"}`} >
    <box vertical={vertical} spacing={vertical ? 0 : 4}>
      <box vertical={vertical} spacing={vertical ? 0 : 4}>
        <label css="font-size:1.75em;font-weight:bold;" label={hour()} />
        <label css="font-size:1.75em;font-weight:bold;" label={minute()} />
      </box>
      <box vertical={!vertical} spacing={vertical ? 2 : 0}
        halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
        <label css="font-size:0.6em;font-weight:bold;" label={day()} />
        <label css="font-size:0.6em;font-weight:bold;" label={month()} />
      </box>
    </box>
  </button >
}