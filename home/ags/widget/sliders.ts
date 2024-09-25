const audio = await Service.import("audio");
import brightness from "lib/brightness";

const default_slider = (icon, value, onChange?) =>
  Widget.Box({
    class_name: "slider",
    css: `min-width: 120px;
          padding: 8px;
          border-radius: 12px;
          background: alpha(@theme_bg_color, 0.25);
          color: @theme_text_color;`,
    children: [
      icon,
      Widget.Slider({
        min: 0,
        max: 100,
        draw_value: false,
        value,
        onChange,
        hexpand: true,
      }),
      Widget.Label({ label: value.as(String) }),
    ],
  });

export const brightnessSlider = () =>
  default_slider(
    Widget.Icon("display-brightness-symbolic"),
    brightness.bind("screen_value").as((v) => Math.floor(v * 100)),
    (self) => (brightness.screen_value = self.value / 100)
  );

export const volumeSlider = () => {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find(
          (threshold) => threshold <= audio.speaker.volume * 100
        );

    return `audio-volume-${icons[icon]}-symbolic`;
  }

  return default_slider(
    Widget.Icon({ icon: Utils.watch(getIcon(), audio.speaker, getIcon) }),
    audio.speaker.bind("volume").as((v) => Math.floor(v * 100)),
    (self) => (audio.speaker.volume = self.value / 100)
  );
};
