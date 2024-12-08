import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";

const hyprland = Hyprland.get_default()
import Media from "./media";
import Battery from "./battery"
import Calendar from "./calendar"

const Title = () => <box
  halign={Gtk.Align.CENTER} css={`
  border-radius:12px;
  padding:4px;
  background: alpha(@theme_bg_color, 0.75);`}>
  <label
    label={"Info Pannel"} css={`
      font-size:2.5em;
      font-weight:bold;
      color:@theme_text_color`} />
</box>

export default (vertical: Variable<boolean>) => <window
  name="infopannel"
  className="infopannel"
  application={App}
  keymode={Astal.Keymode.ON_DEMAND}
  margin={12} visible={false}
  anchor={bind(vertical).as(vertical => vertical ?
    Astal.WindowAnchor.LEFT :
    Astal.WindowAnchor.TOP
  )}
  monitor={bind(hyprland, "focusedMonitor").as(m => m.id)}
  css={`border-radius:12px;
  background: alpha(@theme_bg_color, 0.25);`}
  onKeyPressEvent={(self, event) => {
    const key = event.get_keycode();
    if (key[0] && key[1] == 9) self.hide()
  }}>
  <box vertical spacing={8}
    css={`padding: 4px`}>
    <box spacing={8}>
      <Calendar />
      <box vertical spacing={8}>
        <Title />
        <Battery />
      </box>
    </box>
    <Media />
  </box>
</ window >

