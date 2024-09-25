import { brightnessSlider, volumeSlider } from "widget/sliders";

const audio = await Service.import("audio");
const hyprland = await Service.import("hyprland");
import brightness from "lib/brightness";

const default_popup = (widget, setup) =>
  Widget.Revealer({
    transition_duration: 200,
    reveal_child: false,
    transition: "slide_up",
    child: Widget.Box({
      css: "margin-bottom:48px;",
      child: widget,
    }),
    attribute: { count: 0 },
    setup,
  });

const backlight_popup = () =>
  default_popup(brightnessSlider(), (self) => {
    brightness.connect("screen-changed", (_) => {
      self.attribute.count++;
      if (self.attribute.count > 0) self.reveal_child = true;
      Utils.timeout(1500, () => {
        self.attribute.count--;
        if (self.attribute.count <= 0) self.reveal_child = false;
      });
    });
  });

const volume_popup = () =>
  default_popup(volumeSlider(), (self) => {
    audio.speaker.connect("notify::volume", (_) => {
      self.attribute.count++;
      if (self.attribute.count > 0) self.reveal_child = true;
      Utils.timeout(1500, () => {
        self.attribute.count--;
        if (self.attribute.count <= 0) self.reveal_child = false;
      });
    });
  });

export default () => {
  return Widget.Window({
    monitor: hyprland.active.monitor.bind("id"),
    name: `osd`,
    css: "background-color: rgba(0,0,0,0);",
    child: Widget.Box({
      css: `min-height: 1px; min-width: 360px;`,
      vertical: true,
      children: [backlight_popup(), volume_popup()],
    }),
    class_name: "osd",
    anchor: ["bottom"],
    visible: true,
  });
};
