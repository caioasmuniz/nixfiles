import { Notification } from "types/service/notifications";

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
function NotificationIcon({ app_entry, app_icon, image }) {
  if (image) {
    return Widget.Box({
      css:
        `background-image: url("${image}");` +
        "background-size: contain;" +
        "background-repeat: no-repeat;" +
        "background-position: center;",
    });
  }

  let icon = "dialog-information-symbolic";
  if (Utils.lookUpIcon(app_icon)) icon = app_icon;

  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry;

  return Widget.Box({
    child: Widget.Icon({ icon, size: 48, }),
  });
}

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
export default (notif: Notification) => {
  const icon = Widget.Box({
    vpack: "center",
    class_name: "icon",
    child: NotificationIcon(notif),
  });

  const title = Widget.Label({
    class_name: "title",
    css: `color: @theme_text_color;
          font-size: 16px;`,
    xalign: 0,
    justification: "left",
    hexpand: true,
    max_width_chars: 24,
    truncate: "end",
    wrap: true,
    label: notif.summary,
    use_markup: true,
  });

  const body = Widget.Label({
    class_name: "body",
    css: `color: @theme_text_color;
          font-size: 12px;`,
    hexpand: true,
    use_markup: true,
    xalign: 0,
    justification: "left",
    label: notif.body,
    wrap: true,
  });

  const closeButton = Widget.Button({
    css: `border-radius:12px;
          padding: 0px 4px ;`,
    child: Widget.Icon("window-close-symbolic"),
    on_clicked: () => {
      notif.dismiss();
      notif.close();
    },
  });

  const actions = Widget.Box({
    class_name: "actions",
    children: notif.actions.map(({ id, label }) =>
      Widget.Button({
        hexpand: true,
        css: `border-radius:12px;`,
        class_name: "action-button",
        on_clicked: () => {
          notif.invoke(id);
          notif.dismiss();
        },
        child: Widget.Label(label),
      })
    ),
    //.concat(closeButton),
  });

  return Widget.EventBox({
    attribute: { id: notif.id },
    on_primary_click: notif.dismiss,
    class_name: `notification ${notif.urgency}`,
    child: Widget.Box({
      css: `background-color: @theme_base_color;
            border: 2px @borders;
            border-radius: 12px;
            padding: 4px;`,
      vertical: true,
      children: [
        Widget.Box({
          spacing: 8,
          children: [
            icon,
            Widget.Box({
              vertical: true,
              children: [Widget.Box([title, closeButton]), body],
            }),
          ],
        }),
        actions,
      ],
    }),
  });
};
