import Apps from "gi://AstalApps"
import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland"
import { bind, Variable } from "astal";

const hyprland = Hyprland.get_default()
const apps = new Apps.Apps({
  includeEntry: true,
  includeExecutable: true
})

const list = Variable(apps.fuzzy_query(""))

export default () => <window name="applauncher"
  margin={12} application={App} visible={false}
  keymode={Astal.Keymode.EXCLUSIVE}
  monitor={bind(hyprland, "focusedMonitor").as(m => m.id)}
  anchor={Astal.WindowAnchor.LEFT | Astal.WindowAnchor.TOP}
  css="border-radius: 12px; background: alpha(@theme_bg_color, 0.25);"
  onKeyPressEvent={(self, event) =>
    event.get_keyval()[1] === Gdk.KEY_Escape ? self.hide() : ""
  }>
  <box vertical css={`margin: 6px;`}>
    <entry hexpand css={`
      margin-bottom: 6px;
      border-radius:12px;
      font-size: 2em;
      padding: 8px 4px;
      color: alpha(@theme_text_color,0.5);
      background: alpha(@theme_bg_color, 0.5);`}
      onActivate={self => {
        App.toggle_window("applauncher")
        apps.fuzzy_query(self.text)[0].launch();
      }}
      onChanged={({ text }) =>
        list.set(apps.fuzzy_query(text))
      } />
    <scrollable hscroll={Gtk.PolicyType.NEVER}
      css={`min-width: 350px; min-height: 500px;`}>
      <box vertical spacing={6}>
        {bind(list).as(list =>
          list.map(app =>
            <button css={`border-radius:12px;
              color:@theme_text_color;
              background: alpha(@theme_bg_color, 0.7);`}
              onClick={() => {
                App.toggle_window("applauncher")
                app.launch();
              }}>
              <box spacing={8}>
                <icon icon={app.iconName || ""} css="font-size:4em" />
                <box vertical>
                  <label label={app.name} className="title" xalign={0}
                    css={"font-weight:bold;font-size:1.5em;"} />
                  <label label={app.description} className="description"
                    xalign={0} wrap css={"font-size:0.85em;"} />
                </box>
              </box>
            </button>))}
      </box>
    </scrollable>
  </box>
</window>
