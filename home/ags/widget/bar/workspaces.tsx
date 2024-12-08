import { bind, Variable } from "astal"
import Hyprland from "gi://AstalHyprland"
import Apps from "gi://AstalApps"
import Gtk from "gi://Gtk?version=3.0"

const hyprland = Hyprland.get_default()

const apps = new Apps.Apps({
  nameMultiplier: 4,
  entryMultiplier: 1,
  executableMultiplier: 1,
  descriptionMultiplier: 1,
})

const workspaces = Variable.derive([
  bind(hyprland, "focusedWorkspace"),
  bind(hyprland, "focusedClient"),
  bind(hyprland, "workspaces")
], (focusWs, focusCli, ws) => ({
  data: ws,
  focusedWs: focusCli && focusCli?.workspace.id < 0 ?
    focusCli.workspace :
    focusWs
}))

const getIcon = (client: Hyprland.Client) => {
  switch (client.class) {
    case "code-url-handler":
      return "vscode"
    default:
      return apps.fuzzy_query(client.class).at(0)?.iconName ||
        apps.fuzzy_query(client.title).at(0)?.iconName ||
        apps.fuzzy_query(client.initialTitle).at(0)?.iconName ||
        "image-missing-symbolic"
  }
}

export default ({ monitor, vertical }:
  { monitor: Hyprland.Monitor, vertical: boolean }) =>
  <box
    spacing={4}
    hexpand={vertical}
    vexpand={!vertical}
    vertical={vertical}>
    {bind(workspaces).as(workspaces => workspaces.data
      .filter(ws => ws.monitor === monitor)
      .sort((a, b) => a.id - b.id)
      .map(ws => <button
        cursor={"pointer"}
        onClick={() => {
          if (workspaces.focusedWs.id < 0 || ws.id < 0)
            hyprland.message_async(
              "dispatch togglespecialworkspace scratchpad",
              null)
          if (ws.id > 0)
            ws.focus()
        }}
        css={`border: 1px solid @borders;
              border-radius:12px;
              box-shadow: none;
              padding: ${workspaces.focusedWs === ws ?
            vertical ?
              "8px 2px" :
              "2px 8px" :
            "2px"}; 
              background:${workspaces.focusedWs !== ws && ws.id > 0 ?
            "@theme_bg_color"
            : workspaces.focusedWs !== ws && ws.id < 0 ?
              "mix(@success_color,@theme_bg_color,0.8)"
              : ws.id < 0 ?
                "mix(@success_color,@theme_bg_color,0.5)"
                : "mix(@theme_selected_bg_color,@theme_bg_color,0.5)"
          };`}>
        <box
          spacing={4}
          vertical={vertical}
          halign={Gtk.Align.CENTER}
          valign={Gtk.Align.CENTER}>
          {bind(ws, "clients").as(clients =>
            clients.map(client => <icon
              icon={getIcon(client)}
              css={`font-size:1.5em;
                    box-shadow: none;`} />
            ))}
        </box>
      </button >))}
  </box>

