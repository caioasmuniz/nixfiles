import bar from "./widget/bar/bar.js";
import applauncher from "./widget/applauncher.js";
import quicksettings from "widget/quicksettings/quicksettings.js";
import notificationPopup from "./widget/notifications/notificationPopup.js";

App.config({
  style: "./style.css",
  windows: [
    bar(0),
    bar(1),
    applauncher(),
    quicksettings(),
    notificationPopup(),
  ],
});
