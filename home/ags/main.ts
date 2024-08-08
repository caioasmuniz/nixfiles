import bar from "./widget/bar/bar.js";
import applauncher from "./widget/applauncher.js";
import quicksettings from "widget/quicksettings/quicksettings.js";
import notificationPopup from "./widget/notifications/notificationPopup.js";
import osd from "./widget/osd/osd.js";
import { forMonitors } from "lib/utils.js";

App.config({
  windows: [
    ...forMonitors(bar),
    applauncher(),
    quicksettings(),
    notificationPopup(),
    osd(),
  ],
});
