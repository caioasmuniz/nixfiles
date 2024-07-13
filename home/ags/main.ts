import bar from "./widget/bar/bar.js";
import applauncher from "./widget/applauncher.js";
import quicksettings from "widget/quicksettings/quicksettings.js";
import notificationPopup from "./widget/notifications/notificationPopup.js";
import { forMonitors } from "lib/utils.js";

const hyprland = await Service.import("hyprland");

App.config({
  style: "./style.css",
  windows: [
    ...forMonitors(bar),
    applauncher(),
    quicksettings(),
    notificationPopup(),
  ],
});
