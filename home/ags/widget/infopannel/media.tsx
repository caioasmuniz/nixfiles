import Mpris from "gi://AstalMpris";
import Apps from "gi://AstalApps"
import { bind } from "astal";

const mpris = Mpris.get_default();
const apps = new Apps.Apps()

function lengthStr(length: number) {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
}

const PlaybackButtons = ({ player }: { player: Mpris.Player }) => <box>
  <button onClick={() => player.previous()}
    visible={player.canGoPrevious}>
    <icon icon={"media-skip-backward-symbolic"} />
  </button>

  <button onClick={() =>
    player.playbackStatus === Mpris.PlaybackStatus.PAUSED
      ? player.play() : player.pause()}>
    <icon icon={bind(player, "playbackStatus").as(s =>
      s === Mpris.PlaybackStatus.PLAYING
        ? "media-playback-pause-symbolic"
        : "media-playback-start-symbolic")} />
  </button>

  <button onClick={() => player.next()}
    visible={player.canGoNext}>
    <icon icon={"media-skip-forward-symbolic"} />
  </button>
</box>

export default () => <box vertical spacing={4} css={"min-width:200px;"}
  visible={bind(mpris, "players").as(p => p.length > 0)}>
  {bind(mpris, "players").as(p => p.map(player =>
    <box css={`padding: 10px; background:@theme_bg_color;
    border-radius: 12px;`}>
      <box className={"image"}
        css={`background-image: url('${bind(player, "art_url").as(String)}');`} />
      <box vertical hexpand>
        <box>
          <label className={"title"}
            css={`color:@theme_text_color`}
            wrap label={bind(player, "title")} />
          <icon className={"icon"}
            hexpand
            tooltipText={bind(player, "identity").as(id => id || "")}
            icon={bind(player, "entry").as(entry =>
              apps.fuzzy_query(entry)[0]?.iconName)} />
        </box>
        <label
          className={"artist"}
          css={`color:@theme_text_color`}
          label={bind(player, "artist")} />
        <slider
          className={"position"}
          css={`color:@theme_text_color`}
          drawValue={false}
          onDragged={({ value }) => player.position = value}
          min={0}
          max={bind(player, "length")}
          visible={bind(player, "canSeek")}
          value={bind(player, "position")} />
        <centerbox>
          <label
            css={`color:@theme_text_color`}
            label={bind(player, "position").as(lengthStr)} />
          <PlaybackButtons player={player} />
          <label label={bind(player, "length").as(lengthStr)} css={`color:@theme_text_color`} />
        </centerbox>
      </box>
    </box >
  ))}
</box >
