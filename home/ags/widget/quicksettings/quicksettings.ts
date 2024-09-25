const hyprland = await Service.import("hyprland");
import { brightnessSlider, volumeSlider } from "../sliders";
import notificationList from "./modules/notificationList";
import media from "./modules/media";
import sysTray from "./modules/tray";

const calendar = () =>
  Widget.Calendar({
    css: `border-radius:12px;`,
    showDayNames: true,
    showDetails: true,
    showHeading: true,
  });

const darkMode = () =>
  Widget.Button({
    css: `border-radius:12px;`,
    on_clicked: () => {
      Utils.execAsync(["bash", "-c", "darkman toggle"]);
    },
    child: Widget.Icon("night-light-symbolic"),
  });

const lock = () =>
  Widget.Button({
    css: `border-radius:12px;`,
    on_clicked: () => {
      Utils.execAsync(["bash", "-c", "hyprlock --immediate"]);
    },
    child: Widget.Icon("system-lock-screen-symbolic"),
  });

const poweroff = () =>
  Widget.Button({
    css: `border-radius:12px;`,
    on_clicked: () => {
      Utils.execAsync(["bash", "-c", "systemctl poweroff"]);
    },
    child: Widget.Icon("system-shutdown-symbolic"),
  });

export default () =>
  Widget.Window({
    name: "quicksettings",
    class_name: "quicksettings",
    keymode: "exclusive",
    margins: [12],
    visible: false,
    anchor: ["top", "bottom", "right"],
    monitor: hyprland.active.monitor.bind("id"),
    css: `border-radius:12px;
          background: alpha(@theme_bg_color, 0.25);`,
    child: Widget.Box({
      css: `padding: 4px;
            min-width: 350px;`,
      spacing: 8,
      vertical: true,
      homogeneous: false,
      children: [
        Widget.Box({
          hpack: "center",
          spacing: 8,
          children: [sysTray(), darkMode(), lock(), poweroff()],
        }),
        brightnessSlider(),
        volumeSlider(),
        notificationList(),
        calendar(),
        media(),
      ],
    }),
    setup: (self) =>
      self.keybind("Escape", () => {
        App.closeWindow("quicksettings");
      }),
  });
