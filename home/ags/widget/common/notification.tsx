import Notifd from "gi://AstalNotifd";
import { bind } from "astal"
import { Gtk } from "astal/gtk3";

export default (notif: Notifd.Notification) =>
  <eventbox name={notif.id.toString()}>
    <box vertical
      css={`background-color: @theme_base_color;
          border: 2px @theme_fg_color;
          border-radius: 12px;
          padding: 4px;`}>
      <box spacing={8}>
        <icon icon={notif.app_icon} css={"font-size:2em;"} />
        <box vertical>
          <box>
            <label className="title" hexpand
              css={`color: @theme_text_color;font-size: 16px;`}
              label={notif.summary} />
            <button className="close_button"
              halign={Gtk.Align.END} cursor={"pointer"}
              css={`border-radius:12px; padding: 0px 4px ;`}
              onClicked={() => notif.dismiss()}>
              <icon icon={"window-close-symbolic"} />
            </button>
          </box>
          <label className={"body"}
            css={`color: @theme_text_color;font-size: 12px;`}
            label={notif.body} wrap />
        </box>
      </box>
      <box className={"actions"}>
        {bind(notif, "actions").as(n => n.map((action) =>
          <button onClicked={() => notif.invoke(action.id)}>
            <label label={action.label} />
          </button>))}
      </box>
    </box>
  </eventbox>
