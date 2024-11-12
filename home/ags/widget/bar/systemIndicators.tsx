import Bluetooth from "gi://AstalBluetooth"
import Notifd from "gi://AstalNotifd"
import Network from "gi://AstalNetwork"
import Batery from "gi://AstalBattery"
import Wireplumber from "gi://AstalWp"
import PowerProf from "gi://AstalPowerProfiles"
import { App } from "astal/gtk3";
import { bind } from "astal";

const audio = Wireplumber.get_default()!.audio
const battery = Batery.get_default()
const network = Network.get_default()
const powerprof = PowerProf.get_default()
const notifd = Notifd.get_default()
const bluetooth = Bluetooth.get_default()

const ProfileIndicator = () => <icon
  css={"font-size:1.25em"}
  visible={bind(powerprof, "activeProfile")
    .as(p => p !== "balanced")}
  icon={bind(powerprof, "iconName")}
  tooltipMarkup={bind(powerprof, "active_profile").as(String)} />

const DNDIndicator = () => <icon
  css={"font-size:1.25em"}
  visible={bind(notifd, "dontDisturb")}
  icon="notifications-disabled-symbolic" />

const BluetoothIndicator = () => <icon
  css={"font-size:1.25em"}
  icon="bluetooth-active-symbolic"
  visible={bind(bluetooth.adapter, "powered")} />

const NetworkIndicator = () => <icon
  css={"font-size:1.25em"}
  icon={network[(network.primary == 1 ? "wired" : "wifi")].icon_name}
  visible={network.primary != 0} />

const AudioIndicator = () => <icon
  css={"font-size:1.25em"}
  icon={bind(audio.default_speaker, "volume_icon")}
  tooltipMarkup={bind(audio.default_speaker, "volume")
    .as(v => "Volume: " + (v * 100).toFixed(0).toString() + "%")} />

const MicrophoneIndicator = () => <icon
  css={"font-size:1.25em"}
  visible={bind(audio, "recorders").as(rec => rec.length > 0)}
  icon={bind(audio.default_microphone, "volume_icon")}
  tooltipMarkup={bind(audio.default_microphone, "volume")
    .as(v => (v * 100).toFixed(0).toString() + "%")} />

const BatteryIndicator = () => <icon
  css={"font-size:1.25em"}
  className="battery"
  visible={bind(battery, "is_present")}
  icon={bind(battery, "batteryIconName")}
  tooltipMarkup={bind(battery, "percentage")
    .as((p) => (p * 100).toFixed(0).toString() + "%")} />


export default ({ vertical }: { vertical: boolean }) =>
  <button cursor="pointer"
    hexpand={vertical}
    css="border-radius:12px; padding:2px;"
    onClicked={() => App.toggle_window("quicksettings")}
    onScroll={(self, ev) => ev.delta_y > 0 ?
      audio.default_speaker.volume -= 0.025 :
      audio.default_speaker.volume += 0.025}>
    <box spacing={4} vertical={vertical}>
      {ProfileIndicator()}
      {BluetoothIndicator()}
      {NetworkIndicator()}
      {BatteryIndicator()}
      {MicrophoneIndicator()}
      {AudioIndicator()}
      {DNDIndicator()}
    </box>
  </button>
