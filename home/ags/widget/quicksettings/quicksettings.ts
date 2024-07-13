const hyprland = await Service.import("hyprland");
const systemtray = await Service.import("systemtray");
import { brightnessSlider, volumeSlider } from "../sliders";
import notificationList from "./modules/notificationList";
import media from "./modules/media";

const sysTray = () => {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      })
    )
  );
  return Widget.Box({
    children: items,
  });
};

const calendar = () =>
  Widget.Calendar({
    showDayNames: true,
    showDetails: true,
    showHeading: true,
  });

const darkMode = () =>
  Widget.Button({
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
          background-color:@theme_bg_color`,
    child: Widget.Box({
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
