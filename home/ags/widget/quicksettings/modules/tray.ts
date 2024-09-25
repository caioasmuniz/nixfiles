const systemtray = await Service.import("systemtray");

export default () => {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        css: `border-radius:12px;`,
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      })
    )
  );
  return Widget.Box({
    spacing: 8,
    children: items,
    hpack: "fill",
    css: `border-radius:12px;`,
  });
};
