const notifications = await Service.import("notifications");
import notification from "../../notifications/notification";

export default () =>
  Widget.Box({
    vertical: true,
    spacing: 4,
    children: [
      Widget.Box({
        children: [
          Widget.Label({
            hexpand: true,
            css: `color:@theme_text_color;`,
            label: "Notifications",
          }),
          Widget.Button({
            hpack: "end",
            onClicked: () => {
              notifications.clear();
            },
            child: Widget.Label("Clear All"),
          }),
        ],
      }),
      Widget.Scrollable({
        hscroll: "never",
        vexpand: true,
        child: Widget.Box({
          spacing: 4,
          css: "padding: 4px 0px;min-width: 2px; min-height: 2px;",
          class_name: "notifications",
          vertical: true,
          children: notifications
            .bind("notifications")
            .as((n) => n.map(notification)),
        }),
      }),
    ],
  });
