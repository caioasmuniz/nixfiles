import { bind, execAsync, Variable } from "astal";
import { Gtk } from "astal/gtk3";

const cpu = Variable(0)
  .poll(1000, ["sh", "-c",
    `top -bn1 | rg '%Cpu' | tail -1 | awk '{print 100-$8}'`])

const ram = Variable(0)
  .poll(1000, ["sh", "-c",
    `free | tail -2 | head -1 | awk '{print $3/$2*100}'`],
    out => parseInt(out))

const temp = Variable(0)
  .poll(1000,
    `cat /sys/class/hwmon/hwmon3/temp1_input`,
    out => parseInt(out) / 1000)


const Indicator = ({ value, label, unit, vertical }:
  {
    value: Variable<number>,
    label: string,
    unit: string,
    vertical: boolean
  }) =>
  <box vertical={vertical} spacing={4}>
    <label
      label={label}
      css={`
        color:@theme_text_color;
        font-weight:bold;
        font-size:0.8em;
        `}
    />
    <circularprogress
      startAt={0.25}
      endAt={0.25}
      value={bind(value).as(out => Number(out) / 100)}
      css={`
        color:@theme_text_color;
        min-height:24px;
        font-size:1px;
      `}>
      <label
        label={bind(value).as(v => v
          .toString()
          .concat(unit))}
        css={`color:@theme_text_color;font-size:0.7rem;`}
      />
    </circularprogress >
  </box>

export default ({ vertical }: { vertical: boolean }) =>
  <button
    css={`border-radius:12px;padding:2px`}
    onClicked={() => execAsync(["resources"])}
    cursor="pointer">
    <box
      className="system-info module"
      valign={Gtk.Align.CENTER}
      hexpand={vertical}
      vexpand={!vertical}
      vertical={vertical}
      spacing={4}>
      <Indicator vertical={vertical} value={cpu} label="CPU" unit="%" />
      <Indicator vertical={vertical} value={ram} label="RAM" unit="%" />
      <Indicator vertical={vertical} value={temp} label="TEMP" unit="°C" />
    </box>
  </button >
