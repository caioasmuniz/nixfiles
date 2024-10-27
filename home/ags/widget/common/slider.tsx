import Wireplumber from "gi://AstalWp"
import Brightness from "../../lib/brightness"
import { bind } from "astal"

const brightness = Brightness.get_default()
const audio = Wireplumber.get_default().audio

export enum SliderType {
  AUDIO,
  BRIGHTNESS,
}

export const Slider = ({ type }: { type: SliderType }) =>
  <box css={`min-width: 120px; padding: 8px; 
    border-radius: 12px; color: @theme_text_color;
    background: alpha(@theme_bg_color, 0.25);`}>
    <icon icon={type === SliderType.AUDIO ?
      bind(audio.defaultSpeaker, "volume_icon") :
      "display-brightness-symbolic"}
      css={"font-size:1.5em;"} />
    <slider min={0} max={100}
      drawValue={false} hexpand
      value={type === SliderType.AUDIO ?
        bind(audio.defaultSpeaker, "volume").as(v => v * 100) :
        bind(brightness, "screen").as(v => v * 100)}
      onDragged={({ value }) =>
        type === SliderType.AUDIO ?
          audio.defaultSpeaker.volume = value / 100 :
          brightness.screen = value / 100
      } />
    <label label={type === SliderType.AUDIO ?
      bind(audio.defaultSpeaker, "volume")
        .as(v => Math.floor(v * 100).toString().concat("%")) :
      bind(brightness, "screen")
        .as(v => Math.floor(v * 100).toString().concat("%"))} />
  </box>

