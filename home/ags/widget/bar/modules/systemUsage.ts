const Indicator = (props) =>
  Widget.Box({
    vertical: true,
    vexpand: true,
    margin: 0,
    vpack: "center",
    children: [
      Widget.Label({
        className: "type",
        css: "font-size:0.6em;",
        label: props.type,
      }),
      Widget.Label({
        css: "font-size:0.75em;",
        className: "value",
      }).poll(2000, props.poll),
    ],
  }).poll(2000, props.boxpoll);

const cpu = {
  type: "CPU",
  poll: (self) =>
    Utils.execAsync([
      "sh",
      "-c",
      `top -bn1 | rg '%Cpu' | tail -1 | awk '{print 100-$8}'`,
    ])
      .then((r) => (self.label = Math.round(Number(r)) + "%"))
      .catch((err) => print(err)),

  boxpoll: (self) =>
    Utils.execAsync(["sh", "-c", "lscpu --parse=MHZ"])
      .then((r) => {
        const mhz = r.split("\n").slice(4);
        const freq = mhz.reduce((acc, e) => acc + Number(e), 0) / mhz.length;
        self.tooltipText = Math.round(freq) + " MHz";
      })
      .catch((err) => print(err)),
};

const ram = {
  type: "MEM",
  poll: (self) =>
    Utils.execAsync([
      "sh",
      "-c",
      `free | tail -2 | head -1 | awk '{print $3/$2*100}'`,
    ])
      .then((r) => (self.label = Math.round(Number(r)) + "%"))
      .catch((err) => print(err)),

  boxpoll: (self) =>
    Utils.execAsync([
      "sh",
      "-c",
      "free --si -h | tail -2 | head -1 | awk '{print $3}'",
    ])
      .then((r) => (self.tooltipText = r))
      .catch((err) => print(err)),
};

const temp = {
  type: "TEMP",
  poll: (self) =>
    Utils.execAsync(["sh", "-c", `cat /sys/class/thermal/thermal_zone0/temp`])
      .then((r) => (self.label = Math.round(Number(r) / 1000) + "°C"))
      .catch((err) => print(err)),

  boxpoll: (self) =>
    Utils.execAsync([
      "sh",
      "-c",
      "free --si -h | tail -2 | head -1 | awk '{print $3}'",
    ])
      .then((r) => (self.tooltipText = r))
      .catch((err) => print(err)),
};

export default () =>
  Widget.Button({
    css: `border-radius:12px;`,
    cursor: "pointer",
    onClicked: () => Utils.execAsync(["missioncenter"]),
    child: Widget.Box({
      className: "system-info module",
      spacing: 4,
      children: [Indicator(cpu), Indicator(ram), Indicator(temp)],
    }),
  });
