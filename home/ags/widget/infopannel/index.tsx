import Hyprland from "gi://AstalHyprland"
import { App, Astal } from "astal/gtk3";
import { bind } from "astal";

const hyprland = Hyprland.get_default()
import Media from "./media";
import Battery from "./battery"
import Calendar from "./calendar"

export default () => <window
  name="infopannel"
  className="infopannel"
  application={App}
  keymode={Astal.Keymode.ON_DEMAND}
  margin={12} visible={false}
  anchor={Astal.WindowAnchor.TOP}
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
      <Battery />
    </box>
    <Media />
  </box>
</ window >

