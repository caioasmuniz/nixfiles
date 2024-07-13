const audio = await Service.import("audio");
import brightness from "lib/brightness";

const sliderBox = (value, icon, on_change, setup) => {
  const slider = Widget.Slider({
    css: "padding:0px;",
    hexpand: true,
    draw_value: false,
    value,
    on_change,
  });

  return Widget.Box({
    css: "min-width: 120px",
    children: [icon, slider, Widget.Label(value)],
  });
};

export const brightnessSlider = () => {
  const slider = Widget.Slider({
    hexpand: true,
    css: "padding:0px;",
    draw_value: false,
    value: brightness.bind("screen_value"),
    on_change: (self) => (brightness.screen_value = self.value),
  });

  const label = Widget.Label({
    label: brightness.bind("screen_value").as((v) => `${Math.trunc(v * 100)}`),
    setup: (self) =>
      self.hook(
        brightness,
        (self, screenValue) => {
          self.label = screenValue ?? 0;

          // NOTE:
          // since hooks are run upon construction
          // the passed screenValue will be undefined the first time

          // all three are valid
          self.label = `${brightness.screen_value}`;
        },
        "screen-changed"
      ),
  });
  const icon = Widget.Icon("display-brightness-symbolic");
  return Widget.Box({
    css: "min-width: 120px",
    children: [icon, slider, label],
  });
};

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

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
  });

  const slider = Widget.Slider({
    css: "padding:0px;",
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => (audio.speaker.volume = value),
    value: audio.speaker.bind("volume"),
  });

  return Widget.Box({
    class_name: "volume",
    css: "min-width: 100px",
    children: [icon, slider],
  });
};
