import Wireplumber from "gi://AstalWp"
import { Variable, bind } from "astal"
import { Slider, SliderType } from "../common/slider"
import { Gtk } from "astal/gtk3"

const audio = Wireplumber.get_default().audio
const reveal = Variable(false)


export default () => <box vertical spacing={4}>
  <box>
    <Slider type={SliderType.AUDIO} />
    <button css={"border-radius:0px 12px 12px 0px;"}
      onClicked={() => reveal.set(!reveal.get())}>
      <icon icon={bind(reveal).as(r => r ?
        "go-up-symbolic" : "go-down-symbolic")} />
    </button>
  </box>
  <revealer revealChild={bind(reveal)}>
    <box vertical spacing={4} css={`padding:4px; 
            background:alpha(@theme_bg_color,0.5);
            border-radius:12px;`}>
      {bind(audio, "speakers").as(speakers =>
        speakers.map(speaker =>
          <box>
            <label label={speaker.description}
              css={"color:@theme_text_color"} wrap hexpand />
            <switch halign={Gtk.Align.END} valign={Gtk.Align.CENTER}
              active={bind(speaker, "isDefault")}
              setup={self => self.connect("notify::active", self => {
                speaker.isDefault = self.state
              })} />
          </box>
        ))}
    </box>
  </revealer >
</box>