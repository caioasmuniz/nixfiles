import Apps from "gi://AstalApps"
import { App, Astal, Gdk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland"
import { bind, Variable } from "astal";

const hyprland = Hyprland.get_default()
const apps = new Apps.Apps()
const maxItems = 10;

const text = Variable("")
const list = bind(text).as(text => apps.fuzzy_query(text).slice(0, maxItems))

const AppButton = ({ app }: { app: Apps.Application }) =>
  <button css={`border-radius:12px;
    color:@theme_text_color;
    background: alpha(@theme_bg_color, 0.7);
    min-width:350px;`}
    cursor={"pointer"}
    onClicked={(self) => {
      App.get_window("applauncher")!.hide()
      app.launch();
    }}>
    <box spacing={8}>
      <icon icon={app.iconName || ""} css="font-size:4em" />
      <box vertical>
        <label
          className="title"
          label={app.name}
          xalign={0}
          truncate
          css={"font-weight:bold;font-size:1.5em;"}
        />
        <label
          className="description"
          label={app.description}
          xalign={0}
          wrap
          css={"font-size:0.85em;"}
        />
      </box>
    </box>
  </button>

export default () => <window
  name="applauncher"
  margin={12}
  application={App}
  visible={false}
  keymode={Astal.Keymode.ON_DEMAND}
  exclusivity={Astal.Exclusivity.EXCLUSIVE}
  monitor={bind(hyprland, "focusedMonitor").as(m => m.id)}
  anchor={Astal.WindowAnchor.LEFT | Astal.WindowAnchor.TOP}
  css="border-radius: 12px; background: alpha(@theme_bg_color, 0.25);"
  onShow={() => text.set("")}
  onKeyPressEvent={(self, event) =>
    event.get_keyval()[1] === Gdk.KEY_Escape ? self.hide() : ""
  }>
  <box vertical css={`margin: 6px;`}>
    <entry
      hexpand
      css={`
        margin-bottom: 6px;
        border-radius:12px;
        font-size: 2em;
        padding: 8px 4px;
        color: alpha(@theme_text_color,0.5);
        background: alpha(@theme_bg_color, 0.5);`}
      onChanged={self => text.set(self.text)}
      onActivate={self => {
        App.get_window("applauncher")!.hide()
        apps.fuzzy_query(self.text)[0].launch();
      }}
    />
    <box vertical vexpand spacing={6}>
      {list.as(list =>
        list.map(app =>
          <AppButton app={app} />
        ))}
    </box>
  </box>
</window>
