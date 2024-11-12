import { bind, Variable, execAsync } from "astal"
import Darkman from "../../lib/darkman";

const darkman = Darkman.get_default()

const reveal = Variable(false)

export default () => <box vertical spacing={4}>
  <box>
    <button css={"border-radius:12px 0px 0px 12px;"}
      cursor={"pointer"} onClicked={() => {
        darkman.mode === "light" ?
          darkman.mode = "dark" :
          darkman.mode = "light"
      }}>
      <box spacing={4} hexpand>
        <icon icon={bind(darkman, "icon_name")} />
        <label label={bind(darkman, "mode").as(m => m + " mode")} />
      </box>
    </button>
    <button css={"border-radius:0px 12px 12px 0px;"}
      cursor={"pointer"}
      onClicked={() => reveal.set(!reveal.get())}>
      <icon icon={bind(reveal).as(r => r ?
        "go-up-symbolic" : "go-down-symbolic")} />
    </button>
  </box>
  <revealer revealChild={bind(reveal)}>
    <box vertical spacing={4} css={`padding:4px; 
            background:alpha(@theme_bg_color,0.5);
            border-radius:12px;`}>
      <button css={"border-radius:12px;"} cursor={"pointer"}
        onClicked={() => { darkman.mode = "light" }}>
        <box spacing={4}>
          <icon icon={"weather-clear-symbolic"} />
          <label label={"Light Mode"} />
        </box>
      </button>
      <button css={"border-radius:12px;"} cursor={"pointer"}
        onClicked={() => { darkman.mode = "dark" }}>
        <box spacing={4}>
          <icon icon={"weather-clear-night-symbolic"} />
          <label label={"Dark mode"} />
        </box>
      </button>
    </box>
  </revealer >
</box >