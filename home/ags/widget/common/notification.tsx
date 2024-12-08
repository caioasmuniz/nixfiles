import Notifd from "gi://AstalNotifd";
import { bind } from "astal"
import { Gtk } from "astal/gtk3";

export default (notif: Notifd.Notification) =>
  <eventbox name={notif.id.toString()}>
    <box
      vertical
      css={`
        background-color: @theme_base_color;
        border: 2px @theme_fg_color;
        border-radius: 12px;
        padding: 4px;`}>
      <box spacing={8}>
        <icon
          icon={notif.app_icon}
          css={"font-size:2em;"}
        />
        <box vertical>
          <box>
            <label
              className="title"
              hexpand
              css={`color: @theme_text_color;font-size: 16px;`}
              label={notif.summary} />
            <button
              cursor={"pointer"}
              halign={Gtk.Align.END}
              className="close_button"
              css={`border-radius:12px; padding: 0px 4px ;`}
              onClicked={() => notif.dismiss()}>
              <icon icon={"window-close-symbolic"} />
            </button>
          </box>
          <label
            wrap
            className={"body"}
            label={notif.body}
            css={`color: @theme_text_color;font-size: 12px;`}
          />
        </box>
      </box>
      <box className={"actions"} spacing={4}>
        {bind(notif, "actions").as(n =>
          n.map((action) =>
            <button
              css={"border-radius:12px;"}
              onClicked={() => notif.invoke(action.id)}  >
              <label label={action.label} />
            </button>
          ))}
      </box>
    </box>
  </eventbox>
