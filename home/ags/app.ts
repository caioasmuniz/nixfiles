import { App } from "astal/gtk3";

import style from "./scss/main.css";

import bar from "./widget/bar";
import osd from "./widget/osd";
import applauncher from "./widget/applauncher";
import quicksettings from "./widget/quicksettings";
import notificationPopup from "./widget/notifications";
import infopannel from "./widget/infopannel";

App.start({
  css: style,
  main() {
    bar(false);
    notificationPopup();
    quicksettings();
    infopannel();
    applauncher();
    osd();
  }
});
