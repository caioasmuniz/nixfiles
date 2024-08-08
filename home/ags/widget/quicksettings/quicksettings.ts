const hyprland = await Service.import("hyprland");
import { brightnessSlider, volumeSlider } from "../sliders";
import notificationList from "./modules/notificationList";
import media from "./modules/media";
import sysTray from "./modules/tray";


const calendar = () =>
  Widget.Calendar({
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
    label: "󰔎",
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
          background-color: rgba(0,0,0,0.1);`,
    child: Widget.Box({
      css: `padding: 4px;
            min-width: 350px;`,
      spacing: 8,
      vertical: true,
      homogeneous: false,
      children: [
        darkMode(),
        sysTray(),
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
