import Wireplumber from "gi://AstalWp"
import Hyprland from "gi://AstalHyprland"
import Brightness from "../../lib/brightness"
import { bind, timeout } from "astal"
import { App, Astal, Gtk } from "astal/gtk3"
import { Slider, SliderType } from "../common/slider"
import { Connectable } from "astal/binding"

const brightness = Brightness.get_default()
const audio = Wireplumber.get_default()!.audio
const hyprland = Hyprland.get_default()

const Popup = ({ widget, connectable, signal }:
  { widget: Gtk.Widget, connectable: Connectable, signal: string }) =>
  <revealer transitionDuration={200} revealChild={false}
    transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
    setup={self => {
      connectable.connect(signal, () => {
        if (!self.revealChild) {
          self.revealChild = true
          timeout(1500, () => self.revealChild = false)
        }
      })
    }}>
    <box css={"margin-bottom:48px;min-width:300px;"}>
      {widget}
    </box>
  </revealer>

export default () => <window name={"osd"} visible
  application={App}
  monitor={bind(hyprland, "focusedMonitor").as(m => m.id)}
  css={"background-color: rgba(0,0,0,0)"}
  anchor={Astal.WindowAnchor.BOTTOM}>
  <box vertical>
    <Popup widget={<Slider type={SliderType.AUDIO} />}
      connectable={audio.defaultSpeaker} signal={"notify::volume"} />
    <Popup widget={<Slider type={SliderType.BRIGHTNESS} />}
      connectable={brightness} signal={"notify::screen"} />
  </box>
</window>
