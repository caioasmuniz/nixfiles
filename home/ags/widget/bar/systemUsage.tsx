import { execAsync, interval } from "astal";
import { Astal, Gtk } from "astal/gtk3";

const cpu = {
  type: "CPU",
  poll: (self: Astal.CircularProgress) =>
    execAsync(["sh", "-c",
      `top -bn1 | rg '%Cpu' | tail -1 | awk '{print 100-$8}'`])
      .then(r => self.set_value(Number(r) / 100))
      .catch(err => print(err)),
};

const ram = {
  type: "MEM",
  poll: (self: Astal.CircularProgress) =>
    execAsync(["sh", "-c",
      `free | tail -2 | head -1 | awk '{print $3/$2*100}'`])
      .then(r => self.value = Number(r) / 100)
      .catch(err => print(err)),
};

const temp = {
  type: "TEMP",
  poll: (self: Astal.CircularProgress) =>
    execAsync(["sh", "-c",
      `cat /sys/class/hwmon/hwmon3/temp1_input`])
      .then(r => self.value = Number(r) / 100000)
      .catch(err => print(err)),
};

const Indicator = (props: { type: any; poll: any; }) =>
  <circularprogress
    setup={(self) => interval(1000)
      .connect("now", () => props.poll(self))}
    rounded
    startAt={0.25}
    endAt={0.25}
    css={`color:@theme_text_color;
        min-width:25px;min-height:25px;
        font-size:2px;`}>
    <label
      label={props.type}
      css={`color:@theme_text_color;font-size:8px;`} />
  </circularprogress>

export default ({ vertical }: { vertical: boolean }) =>
  <button cursor="pointer"
    css={`border-radius:12px;
      padding:2px`}
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
