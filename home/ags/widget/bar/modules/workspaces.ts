const { GLib, Gio } = imports.gi;
const decoder = new TextDecoder();
const hyprland = await Service.import("hyprland");
import { FileEnumerator, FileInfo } from "types/@girs/gio-2.0/gio-2.0.cjs";

function getIconNameFromClass(windowClass: string) {
  let formattedClass = windowClass.replace(/\s+/g, "-").toLowerCase();
  let homeDir = GLib.get_home_dir();
  let systemDataDirs = GLib.get_system_data_dirs().map(
    (dir) => dir + "/applications"
  );
  let dataDirs = systemDataDirs.concat([
    homeDir + "/.local/share/applications",
  ]);
  let icon: string | undefined;

  for (let dir of dataDirs) {
    let applicationsGFile = Gio.File.new_for_path(dir);

    let enumerator: FileEnumerator;
    try {
      enumerator = applicationsGFile.enumerate_children(
        "standard::name,standard::type",
        Gio.FileQueryInfoFlags.NONE,
        null
      );
    } catch (e) {
      continue;
    }

    let fileInfo: FileInfo | null;
    while ((fileInfo = enumerator.next_file(null)) !== null) {
      let desktopFile = fileInfo.get_name();
      if (desktopFile.endsWith(".desktop")) {
        let fileContents = GLib.file_get_contents(dir + "/" + desktopFile);
        let matches = /Icon=(\S+)/.exec(decoder.decode(fileContents[1]));
        if (matches && matches[1]) {
          if (desktopFile.toLowerCase().includes(formattedClass)) {
            icon = matches[1];
            break;
          }
        }
      }
    }

    enumerator.close(null);
    if (icon) break;
  }
  return Utils.lookUpIcon(icon) ? icon : "image-missing";
}

export default (monitor: number) => {
  const clients = hyprland.bind("clients");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws
      .sort((a, b) => a.id - b.id)
      .map(({ id, monitorID }) => {
        const clientIcons = clients.as((clients) =>
          clients
            .map((client) => {
              if (client.workspace.id === id)
                return Widget.Icon({
                  size: 20,
                  icon: getIconNameFromClass(client.class),
                });
            })
            .filter((c) => c != undefined)
        );
        return Widget.Button({
          cursor: "pointer",
          tooltip_markup: `${id > 0 ? id : "scratchpad"}`,
          on_clicked: () =>
            id > 0
              ? hyprland.messageAsync(`dispatch workspace ${id}`)
              : hyprland.messageAsync(
                  `dispatch togglespecialworkspace scratchpad`
                ),
          child: Widget.Box({ children: clientIcons, spacing: 8 }),
          attribute: monitorID,
        });
      })
  );

  return Widget.Box({
    class_name: "workspaces",
    spacing: 4,
    children: workspaces,
    setup: (self) =>
      self.hook(hyprland, () =>
        self.children.forEach((btn) => {
          btn.visible = monitor === btn.attribute;
        })
      ),
  });
};
