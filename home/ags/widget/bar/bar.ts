import systemIndicators from "./modules/systemIndicators";
import systemUsage from "./modules/systemUsage";
import workspaces from "./modules/workspaces";
import { brightnessSlider, volumeSlider } from "../sliders";

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
});

function Clock() {
  return Widget.Button({
    class_name: "clock",
    label: date.bind(),
    on_clicked: () => {
      App.toggleWindow("calendar");
    },
  });
}

const launcher = () =>
  Widget.Button({
    on_clicked: () => App.ToggleWindow("applauncher"),
    cursor: "pointer",
    child: Widget.Icon({
      icon: "nix-snowflake-symbolic",
      size: 18,
    }),
  });

export default (monitor: number = 0) =>
  Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    margins: [4],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Widget.Box({
        spacing: 8,
        children: [launcher(), systemUsage(), workspaces(monitor)],
      }),
      center_widget: Widget.Box({
        spacing: 8,
        children: [Clock()],
      }),
      end_widget: Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [systemIndicators()],
      }),
    }),
  });
