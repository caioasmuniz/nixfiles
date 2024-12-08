import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gtk } from "astal/gtk3";
import { bind, execAsync, Variable } from "astal";

const hyprland = Hyprland.get_default()
import { Slider, SliderType } from "../common/slider";
import NotificationList from "./notificationList";
import PwrProf from "./powerprofiles";
import DarkMode from "./darkMode";
import Tray from "./tray";
import AudioConfig from "./audioConfig";

const Lock = () => <button
  cursor={"pointer"}
  css={`border-radius:12px;`}
  onClicked={() => {
    execAsync(["bash", "-c", "hyprlock --immediate"]);
  }}>
  <icon icon={"system-lock-screen-symbolic"} />
</button>

const Poweroff = () => <button
  cursor={"pointer"}
  css={`border-radius:12px;`}
  onClicked={() => {
    execAsync(["bash", "-c", "systemctl poweroff"]);
  }}>
  <icon icon={"system-shutdown-symbolic"} />
</button>

const RotateButton = ({ vertical }:
  { vertical: Variable<boolean> }) => <button
    onClick={() => vertical.set(!vertical.get())}
    css={`border-radius:12px;`}>
    <icon icon={"object-rotate-right-symbolic"} />
  </button>

export default (vertical: Variable<boolean>) => <window
  margin={12}
  visible={false}
  application={App}
  name="quicksettings"
  className="quicksettings"
  keymode={Astal.Keymode.EXCLUSIVE}
  anchor={bind(vertical).as(vertical => vertical ?
    Astal.WindowAnchor.LEFT |
    Astal.WindowAnchor.BOTTOM :
    Astal.WindowAnchor.RIGHT |
    Astal.WindowAnchor.TOP
  )}
  monitor={bind(hyprland, "focusedMonitor")
    .as(m => m.id)}
  css={`border-radius:12px;
  background: alpha(@theme_bg_color, 0.25);`}
  onKeyPressEvent={(self, event) => {
    const key = event.get_keycode();
    if (key[0] && key[1] == 9) self.hide()
  }}>
  <box
    vertical
    spacing={8}
    css={`padding: 4px;min-width: 350px;`}>
    <box spacing={4}>
      <PwrProf />
      <DarkMode />
    </box>
    <box halign={Gtk.Align.CENTER} spacing={8}>
      <Tray />
      <Lock />
      <Poweroff />
      <RotateButton vertical={vertical} />
    </box>
    <Slider type={SliderType.BRIGHTNESS} />
    <AudioConfig />
    <NotificationList />
  </box>
</ window >

