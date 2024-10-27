import Hyprland from "gi://AstalHyprland";
import { App } from "astal/gtk3";

import style from "./scss/main.css";

import bar from "./widget/bar";
import osd from "./widget/osd";
import applauncher from "./widget/applauncher";
import quicksettings from "./widget/quicksettings";
import notificationPopup from "./widget/notifications";

const hyprland = Hyprland.get_default();

App.start({
  css: style,
  main() {
    hyprland.get_monitors().map(m => bar(m, false));
    notificationPopup();
    quicksettings();
    applauncher();
    osd();
  }
});
