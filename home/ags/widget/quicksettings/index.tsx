import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gtk } from "astal/gtk3";
import { bind, execAsync } from "astal";

const hyprland = Hyprland.get_default()
import { Slider, SliderType } from "../common/slider";
import NotificationList from "./notificationList";
import Media from "./media";
import PwrProf from "./powerprofiles";
import DarkMode from "./darkMode";
import Tray from "./tray";
import AudioConfig from "./audioConfig";

const Calendar = () =>
  <Gtk.Calendar
    visible
    showDayNames
    showDetails
    showHeading />

const Lock = () =>
  <button
    css={`border-radius:12px;`}
    onClicked={() => {
      execAsync(["bash", "-c", "hyprlock --immediate"]);
    }}>
    <icon icon={"system-lock-screen-symbolic"} />
  </button>

const Poweroff = () =>
  <button
    css={`border-radius:12px;`}
    onClicked={() => {
      execAsync(["bash", "-c", "systemctl poweroff"]);
    }}>
    <icon icon={"system-shutdown-symbolic"} />
  </button>

export default () => <window
  name="quicksettings"
  className="quicksettings"
  application={App}
  keymode={Astal.Keymode.EXCLUSIVE}
  margin={12} visible={false}
  anchor={Astal.WindowAnchor.BOTTOM
    | Astal.WindowAnchor.RIGHT
    | Astal.WindowAnchor.TOP}
  monitor={bind(hyprland, "focusedMonitor").as(m => m.id)}
  css={`border-radius:12px;
  background: alpha(@theme_bg_color, 0.25);`}
  onKeyPressEvent={(self, event) => {
    const key = event.get_keycode();
    if (key[0] && key[1] == 9) self.hide()
  }}>
  <box spacing={8} vertical
    css={`padding: 4px;min-width: 350px;`}>
    <box spacing={4}>
      <PwrProf />
      <DarkMode />
    </box>
    <box halign={Gtk.Align.CENTER} spacing={8}>
      <Tray />
      <Lock />
      <Poweroff />
    </box>
    <Slider type={SliderType.BRIGHTNESS} />
    <AudioConfig />
    <NotificationList />
    <Calendar />
    <Media />
  </box>
</ window >

