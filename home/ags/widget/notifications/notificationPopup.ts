const notifications = await Service.import("notifications");
const hyprland = await Service.import("hyprland");
import notification from "./notification";

export default () => {
  const list = Widget.Box({
    vertical: true,
    children: notifications.popups.map(notification),
  });

  function onNotified(_, /** @type {number} */ id) {
    const n = notifications.getNotification(id);
    if (n) list.children = [notification(n), ...list.children];
  }

  function onDismissed(_, /** @type {number} */ id) {
    list.children.find((n) => n.attribute.id === id)?.destroy();
  }

  list
    .hook(notifications, onNotified, "notified")
    .hook(notifications, onDismissed, "dismissed");
  const monitor = hyprland.active.monitor.bind("id");
  return Widget.Window({
    monitor,
    name: `notifications${monitor}`,
    class_name: "notification-popups",
    anchor: ["top", "right"],
    child: Widget.Box({
      css: "min-width: 350px; min-height: 2px;",
      class_name: "notifications",
      vertical: true,
      spacing: 4,
      child: list,
    }),
  });
};
