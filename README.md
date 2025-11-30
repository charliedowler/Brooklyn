![](https://github.com/pedrommcarrasco/Brooklyn/blob/master/Design/logo.jpg?raw=true)

> Screen Saver originally by [Pedro Carrasco](https://twitter.com/pedrommcarrasco) based on the animations presented during **[Apple Special Event](https://www.youtube.com/watch?v=bfHEnw6Rm-4)** (October 30, 2018) from the Brooklyn Academy of Music, Howard Gilman Opera House.

<p align="center">
    <img src="https://github.com/pedrommcarrasco/Brooklyn/blob/master/Design/showcase.gif?raw=true" alt="Example"/>
</p>

[![apm](https://img.shields.io/apm/l/vim-mode.svg)](https://github.com/charliedowler/Brooklyn/blob/master/LICENSE)

## Fork Information

This is a maintained fork of the original [Brooklyn](https://github.com/pedrommcarrasco/Brooklyn) screen saver with the following updates:

### macOS Tahoe (26) Compatibility
- Updated deployment target to macOS 14.0+ with Swift 6.0
- Migrated preferences UI from XIB to SwiftUI
- Fixed Swift 6 concurrency issues with `@MainActor` annotations
- Replaced NotificationCenter observers with Combine publishers
- Fixed code signing for screensaver extension
- Fixed video positioning issues (jumping between center and corners)
- Fixed settings persistence in screensaver extension context

### 4K Video Upgrade
- All 75 animation videos upscaled from 1080p to **4K (3840x2160)**
- Used MetalFX AI-powered upscaling via [fx-upscale](https://github.com/finnvoor/fx-upscale)
- Re-encoded to HEVC for optimal quality and file size

## Features

* 4K resolution animations (3840x2160)
* Doesn't require internet connection
* Light & Dark theme support
* Select which animations you want to see
* Loop each animation as many times as you want
* Randomize animation order

<p align="center">
    <img src="https://github.com/pedrommcarrasco/Brooklyn/blob/master/Design/preferenceMenu.png?raw=true" alt="Example"/>
</p>

## Installation 📦

Independently of how you install **Brooklyn**, please **close your System Preferences**.

Screen savers can be set programmatically with this Terminal command :

```shell
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Brooklyn path "$HOME/Library/Screen Savers/Brooklyn.saver"
```

### Manual :hand:

1. [Click here to Download](https://github.com/charliedowler/Brooklyn/releases/latest/download/Brooklyn.saver.zip)
2. Unzip and open **Brooklyn.saver** (double click)
3. If `"Brooklyn.saver" can't be opened because it is from an unidentified developer` appears, press `OK`
4. Open **System Settings** > **Privacy & Security**
5. Scroll down and click **Open Anyway**

Alternatively, run this to bypass quarantine:
```shell
xattr -cr ~/Library/Screen\ Savers/Brooklyn.saver
```

## Uninstallation 🗑️

- Right-click on Brooklyn in System Settings > Screen Saver and select `Delete Brooklyn`, or
- Delete `Brooklyn.saver` from `/Library/Screen Savers` or `~/Library/Screen Savers`

## Compatibility

Requires macOS Sonoma (14.0) or above.

## Contributing

Feel free to contribute by opening [issues](https://github.com/charliedowler/Brooklyn/issues) or [pull requests](https://github.com/charliedowler/Brooklyn/pulls).

## License

Brooklyn is available under the MIT license. See the [LICENSE](https://github.com/charliedowler/Brooklyn/blob/master/LICENSE) file for more information. Logo & original animations are Apple's property.

## Credits

- Original project by [Pedro Carrasco](https://github.com/pedrommcarrasco/Brooklyn)
- 4K upscaling powered by [fx-upscale](https://github.com/finnvoor/fx-upscale)
