# IO Type 84 Pro Wireless — QMK firmware

Open-source [QMK](https://qmk.fm) firmware for the **IO by Red Square Type 84 Pro Wireless**
(USB `0c45:8009`, Sonix **SN32F290** MCU), built on [**qmk-armed**](https://github.com/backflipinc/qmk-armed) —
our QMK fork (SonixQMK + Vial + the qmk-armed protocol) where the keyboard's sources live.
This repository pins a tested qmk-armed commit and adds the build, flash and release tooling around it.

The LCD becomes a real HUD with an on-device settings menu, the light bar under the screen
gets its own modes, keys are remapped live in Vial, and Bluetooth / 2.4 GHz, SnapTap, battery
reporting and auto-sleep all keep working. See [how it compares with the stock firmware](#compared-with-the-stock-firmware).

![On-screen UI](https://github.com/backflipinc/qmk-armed/raw/armed/keyboards/io/type84_pro/docs/images/ui-mockup.png)

> [!WARNING]
> This is an unofficial, reverse-engineered firmware. Flashing is reversible (see
> [Going back to stock](https://github.com/backflipinc/qmk-armed/blob/armed/keyboards/io/type84_pro/docs/flashing.md#going-back-to-stock)), but you do it at your own risk.

## Configure it with Vial Armed

[![Vial Armed](https://github.com/backflipinc/vial-gui-armed/raw/main/docs/screenshots/lighting.png)](https://github.com/backflipinc/vial-gui-armed)

[**Vial Armed**](https://github.com/backflipinc/vial-gui-armed) is the desktop app for this firmware — a Vial fork
in the same design as the keyboard's screen. Flash the firmware ([Quick start](#quick-start)), connect the keyboard by **USB** or
through the **2.4 GHz dongle**, open the app, and everything is in one place:

- **Keymap** — keys and knobs on all layers, macros, tap dance, combos, key overrides, QMK settings, matrix tester;
- **Lighting** — every effect including the 7 two-colour ones, with a live preview on the layout; COLOR, COLOR 2, Fn overlay colour;
- **Lighting > Theme editor** — your own lighting: per-key colours and layers (gradients, rainbow, waves, sparkles, reactive keys, ripples) with any direction, edited live on the keyboard;
- **Light bar** — mode, colour, Caps Lock alert;
- **Device** — NKRO, Win lock, SnapTap mode, Bluetooth slot, auto-sleep;
- **Screen > Settings** — HUD / animation switch, accent colour, screen-off timeout, the HUD clock (set from the PC on connect);
- **Screen > Animation** — your own picture, GIF or video on the LCD, backup and restore;
- **Screen > HUD editor** — lay out the main screen yourself, with your PC's metrics and the output of your scripts on it.

Download it from [Releases](https://github.com/backflipinc/vial-gui-armed/releases): Linux AppImage or .deb, Windows installer
or portable zip, macOS dmg. On Linux, install the [udev rule](#quick-start) (step 3) so the app can reach the keyboard
without root (copy it again when updating from 1.4 or older: 1.5 adds the dongle). Regular [Vial](https://get.vial.today) works too, but only for the keymap and the stock QMK effects.
Everything can also be set without a PC from the [on-screen menu](#on-screen-menu).

## Features

| | |
|---|---|
| ⌨️ **Keys** | Full 84-key layout, NKRO over USB **and** Bluetooth / 2.4 GHz (on by default), QMK keymaps |
| 🧩 **Vial Armed** | Built-in Vial support: remap keys and knobs, macros, combos, tap dance and key overrides live, no reflashing. [Vial Armed](#configure-it-with-vial-armed) also sets the two-colour effects, lighting themes, light bar, Fn colour, auto-sleep, the clock and the screen animation |
| 🎛️ **Knob** | The removable knob works in both spots (Esc or PrtSc): volume, mute, next/prev track on Fn |
| 🖥️ **Display** | 320×172 HUD: layer, WPM, battery, clock, link status, lock indicators — plus a full settings menu. The layout is yours to change in Vial Armed, with the PC's metrics and your scripts' output on it |
| 🎞️ **Animation** | Your own image, GIF or video on the screen instead of the HUD, stored in the same place and format as stock |
| 🌈 **RGB** | Per-key RGB with 30+ effects, including 7 custom **two-colour** effects; black is a colour too |
| 🎨 **Themes** | 4 slots for your own lighting, built from layers and per-key colours in [Vial Armed](#lighting-themes) |
| 🎯 **SnapTap** | The SnapTap switch on the case works: opposing keys A/D and W/S never cancel out — last input wins, or neutral |
| 🔦 **Fn overlay** | Hold Fn and only the keys bound on the Fn layer light up, in a colour of your choice — unless the current theme has its own Fn layers |
| 📏 **Light bar** | The 9-LED strip under the screen: WPM meter, battery gauge, link status, scanner, Caps alert |
| 📡 **Wireless** | Bluetooth (5 host slots) and 2.4 GHz dongle via the built-in radio module, pairing from the keyboard; Vial / Vial Armed work through the dongle too |
| 🔋 **Battery** | Charge level on screen and in the OS — over Bluetooth **and** USB (Linux); not over the 2.4 GHz dongle |
| 💤 **Power** | Auto-sleep in wireless modes after 1 / 5 / 10 / 30 min or never (5 by default); deep sleep, any key, knob or switch wakes it |
| 🛟 **Safety nets** | Hold Esc while plugging in → bootloader; a watchdog drops a hung firmware into the bootloader |

## Compared with the stock firmware

Compared with the official firmware v1.32 and its web configurator (`web.io.vision`).

**What you get on top of stock**

| | Stock | This firmware |
|---|---|---|
| Settings | web configurator (WebHID, Chromium browsers only) | on-device menu on the LCD — no PC or browser needed; Vial for keymaps; [Vial Armed](https://github.com/backflipinc/vial-gui-armed) desktop app for keymaps and lighting with a live preview |
| Screen | images / animations, page switching | live HUD: layer, WPM, battery %, voltage, clock, link, lock and SnapTap state — laid out as you like, with the PC's metrics and scripts' output; settings menu; screen-off timeout; your own image / GIF / video (uploaded with `screen.py`, compatible with stock uploads) |
| Bluetooth hosts | 3 | 5 |
| Battery in the OS | Bluetooth | also over USB (Linux: `upower`, desktop widgets) |
| Keymap power | remap, macros, mod-tap, toggle, key combos | everything QMK has: up to 4 layers live in Vial, tap dance, combos, key overrides, caps word, layer lock, repeat key, auto shift, per-key tapping settings; any QMK feature in code |
| Lighting | stock effects, per-key colours | 30+ QMK effects, 7 **two-colour** effects, 4 **theme** slots (per-key colours, layers, direction), black as a colour, Fn overlay showing only the keys bound on Fn |
| Light bar | effect switch | WPM meter, WPM bar, battery gauge, link status, scanner, Caps alert |
| Auto-sleep | not adjustable in the configurator | 1 / 5 / 10 / 30 min or off, from the keyboard |
| Recovery | bootloader only through the web configurator | hold Esc while plugging in → bootloader; watchdog drops a hung firmware into the bootloader |
| Source | closed | open (GPL-2.0), hardware and radio protocol documented in qmk-armed |

**What stock has and this firmware doesn't (yet)**

- Uploading images from the web configurator — use `screen.py` (below); the stock built-in screen pages aren't shown.
- Key response time (debounce) adjustable at runtime.
- Win / Mac mode switch (Fn+M) and Cmd lock.
- Configurable SnapTap pairs and the two "key priority" modes — fixed to A/D and W/S, last input or neutral, for now.
- Firmware updates from the web configurator — flashing is done with `flash.sh`.

## Quick start

Ready-made firmware is attached to every [release](https://github.com/backflipinc/io-type84-pro-qmk/releases)
(`io_type84_pro_default.bin` with Vial, `io_type84_pro_novial.bin` without) — skip to step 3.
To build it yourself you need: Linux (macOS should work too), `git`, `make`, Python 3 with [`qmk`](https://pypi.org/project/qmk/)
(`pip install qmk`), an `arm-none-eabi-gcc` toolchain, and
[SonixFlasherC](https://github.com/SonixQMK/SonixFlasherC) (`sonixflasher`).

```sh
# 1. get the sources: qmk-armed at the pinned commit
git clone https://github.com/backflipinc/io-type84-pro-qmk.git
cd io-type84-pro-qmk
./setup.sh

# 2. build
make -C qmk-armed io/type84_pro:default       # with Vial; io/type84_pro:novial — without

# 3. allow flashing without sudo (once)
sudo cp qmk-armed/keyboards/io/type84_pro/udev/70-io-type84-pro.rules /etc/udev/rules.d/ && sudo udevadm control --reload

# 4. flash — set the mode switch to USB first
./flash.sh                                     # or ./flash.sh path/to/io_type84_pro_default.bin
```

`flash.sh` puts the keyboard into its bootloader by itself — stock, or this firmware from 1.5 on
(`tools/bootloader.py`). With older builds, enter the bootloader from the menu
(**Fn+Enter → SYSTEM → BOOTLOADER**) or **hold Esc while plugging the cable in**. Details, recovery and going back to stock: [flashing.md](https://github.com/backflipinc/qmk-armed/blob/armed/keyboards/io/type84_pro/docs/flashing.md).

## Using it

### Fn layer

| Keys | Action |
|---|---|
| **Fn+Enter** | Open the menu / select / confirm |
| **Fn+Ctrl** (either) | Back / cancel |
| **Fn+arrows** | Navigate the menu and change values. Outside the menu: **↑↓** brightness, **←→** main screen: HUD 1, HUD 2, HUD 3, animation |
| **Fn+Space** | Lighting on / off |
| **Fn+H / J**, **Fn+K / L** | Hue − / +, effect speed − / + |
| **Fn+1 … 5** | Bluetooth slot 1–5 — **hold 3 s to pair** |
| **Fn+6** | In 2.4 GHz mode: **hold 3 s** to pair with the dongle |
| **Fn+S** | Auto-sleep timer: 5 → 10 → 30 min → off → 1 min |
| **Fn+N**, **Fn+Win** | NKRO on/off, Win key lock |
| **Fn+PgUp / PgDn** | Home / End |
| **Fn+F1 / F2**, **F5–F7**, **F9–F11** | Monitor brightness − / +, media prev/play/next, mute / volume |
| Knob | Volume (Fn: previous / next track); press = mute. In the menu: scroll and select |

The **mode switch** on the back selects USB / Bluetooth / 2.4 GHz. In wireless modes the
keyboard disconnects from USB, just like the stock firmware (the cable only charges).

### On-screen menu

| Page | Settings |
|---|---|
| **LIGHTING** | on/off, effect, colour, colour 2 (two-colour effects), Fn overlay colour, brightness, hue, saturation, speed |
| **LIGHT BAR** | mode (WPM, WPM bar, battery, link, scanner, off), colour, Caps Lock alert |
| **SNAPTAP** | switch state, mode (last input / neutral), key pairs |
| **WIRELESS** | current mode, Bluetooth slot, pair now |
| **POWER** | auto-sleep timer, battery %, voltage, charging status |
| **DISPLAY** | UI accent colour (amber, green, cyan, red, white), screen-off timeout (30 s – 10 min or off), main screen (HUD 1–3 / animation), clock (24H / 12H / off), stored animation info |
| **SYSTEM** | NKRO, Win lock, bootloader, factory reset (both with a confirmation) |
| **ABOUT** | firmware, build date, MCU, uptime |

The menu closes by itself after 30 s. Settings are stored in the keyboard.

### Lighting

Besides the stock QMK effects there are custom two-colour effects that use **COLOR** and
**COLOR 2** from the menu: **TWO TONE** (letters / modifiers), **GRADIENT 2**, **CROSSFADE 2**,
**SCANNER 2**, **STARLIGHT 2**, **REACTIVE 2** and **RIPPLE 2** (both react to key presses).
Rows that the current effect doesn't use are dimmed in the menu.

### Lighting themes

**THEME 1** … **THEME 4** are effects you build yourself in **Lighting > Theme editor** of
[Vial Armed](https://github.com/backflipinc/vial-gui-armed). A theme is a stack of up to 8 layers:

- **SOLID**, **GRADIENT**, **RAINBOW**, **PULSE** — colours across the keys, still or moving;
- **WAVE** — a band of colour sweeping over the layers below;
- **SPARKLE** — random keys flashing;
- **REACTIVE**, **RIPPLE** — keys lighting up when pressed, rings spreading from them;
- **PAINT** — your own colour on every key.

Every layer covers all keys, the keys of a keymap layer (FN1, FN2, FN3: what is bound there and the keys that bring
it up, tri-layer keys included; the keyboard follows remaps by itself), or the keys you click on the layout (or a group:
letters, F-row, mods, arrows, WASD). It moves in any direction or out from a key you pick, blends over the layers below,
and can show only while Caps Lock is on or a keymap layer is active (a theme with such layers replaces the Fn overlay). Changes show up on the keyboard as you make them; **SAVE** keeps them and makes the theme the current effect. Start from a preset, and
export / import themes as files. The themes are stored in the user flash chip, past the area the stock firmware uses.

### SnapTap

Flip the **SnapTap** switch on the case to turn it on: the screen shows *SNAPTAP ON*, the
A/D and W/S keys blink and a **SNAPTAP** tile lights up on the main screen. While both keys
of a pair are held, only one reaches the host — the last one pressed (**LAST**), or neither
(**NEUTRAL**, set in the menu). Turn it off for typing: fast rollovers like "ad" would retype a letter.

### Vial and Vial Armed

The default build includes Vial. Connect the keyboard by **USB**, or set the mode switch to **2.4 GHz** with
the dongle plugged in, and open
[Vial Armed](https://github.com/backflipinc/vial-gui-armed) (or regular [Vial](https://get.vial.today)) — the keyboard is detected by itself. Keys and knobs can be
remapped on 4 layers; the keyboard's own keys (Bluetooth slots, pairing, menu, sleep timer)
are under **User**. Changes that need unlocking ask you to hold **Caps + Enter**.
Through the dongle every request takes ~20 ms, so connecting takes a few seconds; regular Vial doesn't recognise
the dongle (no Vial serial number), Vial Armed does. Bluetooth has no channel for it.

On top of everything Vial does, Vial Armed sets what stock Vial can't: all effects
including the two-colour ones (with a live preview on the layout), COLOR 2, the Fn overlay colour, lighting themes, the light
bar, the auto-sleep timer, the screen animation and the HUD layout. It talks to the keyboard over the [qmk-armed protocol](https://github.com/backflipinc/qmk-armed/blob/armed/docs/armed.md);
regular Vial keeps working as before.

### Your own HUD

The main screen is a layout of widgets you can change: text with live values, bars, graphs, indicator tiles, the
battery icon, frames and lines, multi-line text. [Vial Armed](https://github.com/backflipinc/vial-gui-armed)'s
**Screen > HUD editor** edits it on a pixel-exact preview (the keyboard's own fonts and colour roles, so it keeps the look of
the firmware and follows DISPLAY > ACCENT); every change is live, SAVE stores it on the keyboard, START FROM >
KEYBOARD DEFAULT brings back the stock layout. The keyboard keeps three layouts; **Fn+Left / Fn+Right** go through
them and the animation, and the editor follows whichever is shown.

Besides the keyboard's own values (layer, WPM, battery, voltage, link, clock, locks, SnapTap, effect, uptime, ...),
widgets can show 16 numbers and 4 texts sent by the PC: Vial Armed's agent fills them with CPU / GPU load and
temperature, RAM, network, disk and so on, or with the output of your own commands and scripts. It runs while Vial
Armed is open (closing it leaves it in the system tray), or without a window as `vial-armed --agent` (RUN AT LOGIN on Linux and Windows), over USB and the 2.4 GHz
dongle; the values don't keep a wireless keyboard awake. The fonts are ASCII: the agent spells Cyrillic in Latin
letters.

### Your own animation on the screen

[Vial Armed](https://github.com/backflipinc/vial-gui-armed) does it under **Screen > Animation** (preview, fit, progress,
backup / restore). From the command line, `screen.py` puts a picture, a GIF (or animated WebP / PNG) or a video on the screen. It needs Python with
`pip install hid pillow numpy`, and `ffmpeg` for video. The mode switch must be on **USB**.

```sh
T=qmk-armed/keyboards/io/type84_pro/tools/screen.py
python3 $T upload cat.gif                  # fit inside 320×172 with black bars; --fit cover fills and crops
python3 $T upload clip.mp4 --fps 12        # video: frames are taken at --fps (default 10)
python3 $T upload a.png b.png --delay 3000 # slideshow
python3 $T mode hud                        # back to the HUD (or DISPLAY > MAIN SCREEN in the menu)
python3 $T dump backup.bin                 # save what is stored (slow: ~4 s per frame); upload --raw backup.bin restores it
```

Up to 151 frames are stored (one 320×172 frame is 108 KiB). The animation lives where the stock firmware
keeps its own, in the same format: the one that came with the keyboard (or that you uploaded with the stock
configurator) plays here too, and yours keeps playing if you go back to stock. Uploading replaces it —
`dump` it first if you want to keep it. The stock built-in images on the other flash chip are never written.

### Battery in your OS

- **Bluetooth:** shown by the OS like any wireless keyboard.
- **2.4 GHz:** not shown, on stock firmware either: the dongle doesn't pass the charge level to the host.
  Check it on the keyboard's screen or light bar.
- **USB (Linux):** the firmware exposes a standard HID battery, so `upower` and desktop
  battery widgets list the keyboard with its charge and charging state.

## Updating qmk-armed

`qmk-armed` is a git submodule on the fork's `armed` branch. To move to a newer commit:

```sh
git -C qmk-armed fetch --depth 1 origin armed && git -C qmk-armed checkout FETCH_HEAD
git add qmk-armed && git commit -m "Update qmk-armed"
```

Keyboard changes go to [qmk-armed](https://github.com/backflipinc/qmk-armed) first.

## Documentation

| | |
|---|---|
| [flashing.md](https://github.com/backflipinc/qmk-armed/blob/armed/keyboards/io/type84_pro/docs/flashing.md) | Flashing, recovery, going back to stock |
| [hardware.md](https://github.com/backflipinc/qmk-armed/blob/armed/keyboards/io/type84_pro/docs/hardware.md) | Reverse-engineered hardware map: pins, matrix, LEDs, display, radio, battery |
| [radio-protocol.md](https://github.com/backflipinc/qmk-armed/blob/armed/keyboards/io/type84_pro/docs/radio-protocol.md) | UART protocol between the MCU and the BT / 2.4 GHz module |
| [development.md](https://github.com/backflipinc/qmk-armed/blob/armed/keyboards/io/type84_pro/docs/development.md) | How the port is built, gotchas, customising, debugging |

## Status and limitations

- Tested on one keyboard (stock firmware v1.32), on Linux.
- The clock is set by Vial Armed when it connects (the RTC chip keeps it through sleep and unplugging); PC metrics and script output reach the screen while Vial Armed or its agent runs (USB and the 2.4 GHz dongle, not Bluetooth).
- Animation uploads go over Vial's 32-byte raw HID reports, ~26 KiB/s: a few seconds for a cartoon-like GIF,
  about 4 s per frame of video (151 frames ≈ 10 min).
- Like stock, frames reach the screen without vsync: fast high-contrast motion may show tearing.
- Vial works over USB and the 2.4 GHz dongle, not over Bluetooth (the radio module has no channel for it).
  Screen animations are transferred over USB only (megabytes at ~20 ms per 28-byte packet).
- The OS sees the battery over Bluetooth and USB, not over the 2.4 GHz dongle (stock has the same limit).
- System power keys and mouse keys are not sent over the air (format unverified).
- The USB battery report narrows QMK's *System Control* report to power / sleep / wake, so
  `KC_SYSTEM_RESTART` and similar rarely used keys do nothing.

## Credits

- [QMK](https://github.com/qmk/qmk_firmware) and [SonixQMK](https://github.com/SonixQMK/qmk_firmware) — the firmware and the SN32 port
- [Vial](https://get.vial.today) / [vial-qmk](https://github.com/vial-kb/vial-qmk) — live remapping, and the base of
  [Vial Armed](https://github.com/backflipinc/vial-gui-armed), the companion app
- [SonixFlasherC](https://github.com/SonixQMK/SonixFlasherC) — the flasher
- [ChibiOS](https://www.chibios.org) / ChibiOS-Contrib — the RTOS and HAL
- Fonts: [Share Tech Mono](https://fonts.google.com/specimen/Share+Tech+Mono) and
  [Rajdhani](https://fonts.google.com/specimen/Rajdhani) (SIL Open Font License, see `keyboards/io/type84_pro/graphics/fonts/` in qmk-armed)

Not affiliated with IO by Red Square.

## License

GPL-2.0-or-later, like QMK — see [LICENSE](LICENSE). The bundled fonts are under the
SIL Open Font License 1.1.
