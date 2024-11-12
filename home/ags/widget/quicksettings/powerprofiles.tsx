import Powerprofiles from "gi://AstalPowerProfiles"
import { bind, Variable } from "astal"

const profile = Powerprofiles.get_default()
const reveal = Variable(false)

export default () => <box vertical spacing={4}>
  <box>
    <button css={"border-radius:12px 0px 0px 12px;"}
      cursor={"pointer"}
      onClicked={() => {
        const p = profile.get_active_profile()
        if (p === "power-saver")
          profile.set_active_profile("balanced")
        else if (p === "balanced")
          profile.set_active_profile("performance")
        else
          profile.set_active_profile("power-saver")
      }}>
      <box spacing={4} hexpand>
        <icon icon={bind(profile, "icon_name")} />
        <label label={bind(profile, "active_profile")} />
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
        onClicked={() => profile.set_active_profile("power-saver")}>
        <box spacing={4}>
          <icon icon={"power-profile-power-saver-symbolic"} />
          <label label={"Power Saver"} />
        </box>
      </button>
      <button css={"border-radius:12px;"} cursor={"pointer"}
        onClicked={() => profile.set_active_profile("balanced")}>
        <box spacing={4}>
          <icon icon={"power-profile-balanced-symbolic"} />
          <label label={"Balanced"} />
        </box>
      </button>
      <button css={"border-radius:12px;"} cursor={"pointer"}
        onClicked={() => profile.set_active_profile("performance")}>
        <box spacing={4}>
          <icon icon={"power-profile-performance-symbolic"} />
          <label label={"Performance"} />
        </box>
      </button>
    </box>
  </revealer>
</box>