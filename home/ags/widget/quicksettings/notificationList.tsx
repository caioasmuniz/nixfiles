import Notifd from "gi://AstalNotifd";
import { Gtk } from "astal/gtk3";
import { bind } from "astal";
import notification from "../common/notification";

const notifd = Notifd.get_default();


const DNDButton = () => <box spacing={4} css={`
  background:@theme_bg_color;
  border-radius:12px;
  padding:4px;`}>
  <icon icon={"notifications-disabled-symbolic"} css={`
    font-size:1.25em;
    color:@theme_text_color;`} />
  <label label={"Do Not Disturb"} css={"color:@theme_text_color;"} />
  <switch valign={Gtk.Align.CENTER} active={bind(notifd, "dontDisturb")}
    setup={self => self.connect("notify::active", self => {
      notifd.dontDisturb = self.state
    })} />
</box>

const ClearAllButton = () => <button
  css={"border-radius:12px;"}
  halign={Gtk.Align.END}
  onClicked={() => notifd.get_notifications().
    forEach(n => n.dismiss())}>
  <box spacing={4}>
    <icon icon={"edit-clear-all-symbolic"} css={"font-size:1.25em;"} />
    <label label={"Clear All"} css={"font-weight:bold;"} />
  </box>
</button >

export default () => <box vertical spacing={4}>
  <box vertical spacing={4}>
    <label label={"Notifications"} css={`
  font-weight:bold;
  font-size:1.25em;
  color:@theme_text_color`} />
    <box halign={Gtk.Align.CENTER} spacing={4}>
      <DNDButton />
      <ClearAllButton />
    </box>
  </box>
  <scrollable vexpand={true} hscroll={Gtk.PolicyType.NEVER}>
    <box vertical spacing={6}>
      {bind(notifd, "notifications").as(n => n.map(notification))}
    </box>
  </scrollable>
</box>