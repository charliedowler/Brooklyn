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

* Doesn't require internet connection
* Light & Dark theme
* 4K resolution animations
* Select which animations you want to see
* Loop each animation how many times you want
* Make the animations' order random

<p align="center">
    <img src="https://github.com/pedrommcarrasco/Brooklyn/blob/master/Design/preferenceMenu.png?raw=true" alt="Example"/>
</p>

## Installation

**Close System Preferences/Settings before installing.**

### Download from GitHub Releases

1. Download the latest `Brooklyn.saver.zip` from [Releases](https://github.com/charliedowler/Brooklyn/releases)
2. Unzip and double-click **Brooklyn.saver**
3. If you see `"Brooklyn.saver" can't be opened because it is from an unidentified developer`, press `OK`
4. Open **System Settings** > **Privacy & Security**
5. Scroll down and click **Open Anyway**

### Build from Source

1. Clone this repository
2. Open `Brooklyn.xcodeproj` in Xcode
3. Build the project (Cmd+B)
4. The built `Brooklyn.saver` will be in `DerivedData/Brooklyn/Build/Products/Release/`
5. Double-click to install

### Homebrew (Custom Tap)

You can install via Homebrew using a custom tap:

```shell
brew tap charliedowler/brooklyn
brew install --cask brooklyn-4k --no-quarantine
```

> Note: The tap needs to be created first. See [Creating a Homebrew Tap](#creating-a-homebrew-tap) below.

### Post-Installation

To set Brooklyn as your screen saver programmatically:

```shell
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Brooklyn path "$HOME/Library/Screen Savers/Brooklyn.saver"
```

## Uninstallation

- Right-click on Brooklyn in System Settings > Screen Saver and select `Delete Brooklyn`, or
- Delete `Brooklyn.saver` from `/Library/Screen Savers` or `~/Library/Screen Savers`

## Compatibility

Requires macOS Sonoma (14.0) or above.

## Troubleshooting

The Brooklyn screen saver can be blocked by macOS as unidentified software.

To bypass quarantine, run this command in Terminal:

```shell
xattr -cr ~/Library/Screen\ Savers/Brooklyn.saver
```

If that doesn't work, try with sudo:

```shell
sudo xattr -cr ~/Library/Screen\ Savers/Brooklyn.saver
```

## Creating a Homebrew Tap

To distribute via Homebrew, create a tap repository:

1. Create a new repo named `homebrew-brooklyn`
2. Add a file `Casks/brooklyn-4k.rb`:

```ruby
cask "brooklyn-4k" do
  version "3.0.0"
  sha256 "YOUR_SHA256_HERE"

  url "https://github.com/charliedowler/Brooklyn/releases/download/v#{version}/Brooklyn.saver.zip"
  name "Brooklyn 4K"
  desc "macOS screen saver with Apple Brooklyn event animations in 4K"
  homepage "https://github.com/charliedowler/Brooklyn"

  screen_saver "Brooklyn.saver"

  zap trash: [
    "~/Library/Screen Savers/Brooklyn.saver",
  ]
end
```

3. Create a GitHub release with `Brooklyn.saver.zip`
4. Update the sha256 in the cask file

## Contributing

Feel free to contribute by opening [issues](https://github.com/charliedowler/Brooklyn/issues) or [pull requests](https://github.com/charliedowler/Brooklyn/pulls).

## License

Brooklyn is available under the MIT license. See the [LICENSE](https://github.com/charliedowler/Brooklyn/blob/master/LICENSE) file for more information. Logo & original animations are Apple's property.

## Credits

- Original project by [Pedro Carrasco](https://github.com/pedrommcarrasco/Brooklyn)
- 4K upscaling powered by [fx-upscale](https://github.com/finnvoor/fx-upscale)
