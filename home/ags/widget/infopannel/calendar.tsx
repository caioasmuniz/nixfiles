import { Gtk, astalify } from "astal/gtk3"

const Calendar = astalify(Gtk.Calendar)

export default () =>
  <Calendar
    css={`
      border-radius:12px;
      background: @theme_bg_color;
      `}
    showDayNames
    showDetails
    showHeading />