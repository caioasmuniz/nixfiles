import { execAsync, interval } from "astal";
import { Astal, Gtk } from "astal/gtk3";

const cpu = {
  type: "CPU",
  poll: (self: Astal.Label) =>
    execAsync([
      "sh",
      "-c",
      `top -bn1 | rg '%Cpu' | tail -1 | awk '{print 100-$8}'`,
    ])
      .then((r) => (self.set_label(Math.round(Number(r)) + "%")))
      .catch((err) => print(err)),
};

const ram = {
  type: "MEM",
  poll: (self: Astal.Label) =>
    execAsync([
      "sh",
      "-c",
      `free | tail -2 | head -1 | awk '{print $3/$2*100}'`,
    ])
      .then((r) => (self.label = Math.round(Number(r)) + "%"))
      .catch((err) => print(err)),
};

const temp = {
  type: "TEMP",
  poll: (self: Astal.Label) =>
    execAsync(["sh", "-c", `cat /sys/class/thermal/thermal_zone0/temp`])
      .then((r) => (self.label = Math.round(Number(r) / 1000) + "°C"))
      .catch((err) => print(err)),
};

const Indicator = (props: { type: any; poll: any; }) =>
  <box vertical vexpand>
    <label className="type" label={props.type}
      css="font-size:0.65em;font-weight:bold;" />
    <label className="value" width_chars={4}
      setup={(self) => {
        interval(1000).connect("now",
          () => { props.poll(self) })
      }}
      css="font-size:0.8em;" />
  </box>

export default ({ vertical }: { vertical: boolean }) =>
  <button cursor="pointer"
    css={`border-radius:12px;
      padding:${vertical ? "4px 0px;" : "0px 4px;"}`}
    onClicked={() => execAsync(["missioncenter"])}>
    <box className="system-info module"
      vexpand={!vertical} hexpand={vertical}
      vertical={vertical} valign={Gtk.Align.CENTER}
      spacing={4}>
      {Indicator(cpu)}
      {Indicator(ram)}
      {Indicator(temp)}
    </box>
  </button >
