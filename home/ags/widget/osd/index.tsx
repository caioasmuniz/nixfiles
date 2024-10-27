import Wireplumber from "gi://AstalWp"
import Hyprland from "gi://AstalHyprland"
import Brightness from "../../lib/brightness"
import { bind, timeout } from "astal"
import { App, Astal, Gtk } from "astal/gtk3"
import { Slider, SliderType } from "../common/slider"

const brightness = Brightness.get_default()
const audio = Wireplumber.get_default().audio
const hyprland = Hyprland.get_default()

const Popup = ({ type }: { type: SliderType }) =>
  <revealer transitionDuration={200} revealChild={false}
    transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
    setup={self => {
      const showOsd = (self: Gtk.Revealer) => {
        if (!self.revealChild) {
          self.revealChild = true
          timeout(1500, () => self.revealChild = false)
        }
      }
      type == SliderType.AUDIO ?
        audio.defaultSpeaker.connect("notify::volume", () => showOsd(self)) :
        brightness.connect("notify::screen", () => showOsd(self))
    }}>
    <box css={"margin-bottom:48px;min-width:300px;"}>
      <Slider type={type} />
    </box>
  </revealer>

export default () => <window name={"osd"} visible
  application={App}
  monitor={bind(hyprland, "focusedMonitor").as(m => m.id)}
  css={"background-color: rgba(0,0,0,0)"}
  anchor={Astal.WindowAnchor.BOTTOM}>
  <box vertical>
    <Popup type={SliderType.AUDIO} />
    <Popup type={SliderType.BRIGHTNESS} />
  </box>
</window>
