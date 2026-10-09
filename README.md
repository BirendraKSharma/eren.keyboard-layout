# eren.keyboard-layout

A Fcitx5 input method widget for Omarchy bar. Shows and toggles the current Fcitx5 input method (English/Japanese Mozc).

## Features

- Displays current input method state in the bar (EN / あ)
- Click to toggle between English and Japanese (Mozc) input
- Tooltip shows current state and action
- Polls Fcitx5 status every 750ms for real-time updates

## Installation

```bash
omarchy plugin install eren.keyboard-layout
```

Or manually clone to `~/.config/omarchy/plugins/eren.keyboard-layout`

## Requirements

- Fcitx5 with Mozc (Japanese input method)
- `fcitx5-remote` command available

## Configuration

The widget works automatically with Fcitx5. No additional configuration needed.

## License

MIT