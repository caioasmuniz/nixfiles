import Tray from "gi://AstalTray";
import { Gtk } from "astal/gtk3";
import { bind } from "astal";

const tray = Tray.get_default();

export default () => <box spacing={8}
  halign={Gtk.Align.FILL} css={`border-radius:12px;`}>
  {bind(tray, "items").as(items => items.map(item =>
    <button css={`border-radius:12px;`}
      cursor={"pointer"}
      onClick={(self, event) => {
        if (event.button === 3) {
          const menu = item.create_menu()
          menu?.popup_at_pointer(null)
        }
        else if (event.button === 1)
          item.activate(0, 0)
      }} tooltip_markup={bind(item, "tooltip_markup")}>
      <icon icon={item.iconName} />
    </button>))}
</box >