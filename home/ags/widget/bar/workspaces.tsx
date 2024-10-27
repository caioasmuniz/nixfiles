import { bind, Variable } from "astal"
import Hyprland from "gi://AstalHyprland"
import Apps from "gi://AstalApps"

const hyprland = Hyprland.get_default()

const apps = new Apps.Apps({
  includeName: true,
  includeEntry: true,
  includeExecutable: true,
  includeDescription: true,
})

const workspaces = Variable.derive([
  bind(hyprland, "focusedWorkspace"),
  bind(hyprland, "focusedClient"),
  bind(hyprland, "workspaces")
], (focusWs, focusCli, ws) =>
  ws.map(ws => ({
    data: ws,
    focused: ws.id < 0 ?
      focusCli && focusCli?.workspace.id === ws.id :
      focusWs.id === ws.id,
  })))

const getIcon = (client: Hyprland.Client) => {
  const classQuery = apps.fuzzy_query(client.class).at(0)
  const titleQuery = apps.fuzzy_query(client.title).at(0)
  const initTitleQuery = apps.fuzzy_query("Visual Studio Code").at(0)
  const result = classQuery?.iconName || titleQuery?.iconName ||
    initTitleQuery?.iconName

  console.log(`INIT TITLE: ${client.initialTitle}\t\tQUERY: ${initTitleQuery?.name}`)
  console.log("RESULT: " + result)
  return result || ""
}

export default ({ monitor, vertical }:
  { monitor: Hyprland.Monitor, vertical: boolean }) =>
  <box vertical={vertical} spacing={4}
    hexpand={vertical} vexpand={!vertical}>
    {bind(workspaces).as(ws => ws
      .filter(ws => ws.data.monitor === monitor)
      .sort((a, b) => a.data.id - b.data.id)
      .map(ws => <button onClick={() => ws.data.id < 0 ?
        hyprland.message_async("dispatch togglespecialworkspace scratchpad", null) :
        ws.data.focus()}
        cursor={"pointer"}
        css={`transition:all 500ms;  
              border: 1px solid @borders;
              padding: 2px; 
              border-radius:12px;
              background:${!ws.focused && ws.data.id > 0 ?
            "@theme_bg_color"
            : !ws.focused && ws.data.id < 0 ?
              "mix(@success_color,@theme_bg_color,0.8)"
              : ws.data.id < 0 ?
                "mix(@success_color,@theme_bg_color,0.5)"
                : "mix(@theme_selected_bg_color,@theme_bg_color,0.5)"
          };`}>
        <box spacing={4} vertical={vertical}>
          {bind(ws.data, "clients").as(clients =>
            clients.map(client => <icon
              icon={getIcon(client)}
              css="font-size:1.5em" />
            ))}
        </box>
      </button >))}
  </box>

