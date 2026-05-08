<img align="left" width="80" height="80"
src=".github/repo_icon.png" alt="App icon">

# FlorisBoard [![Crowdin](https://badges.crowdin.net/florisboard/localized.svg)](https://crowdin.florisboard.org) [![Matrix badge](https://img.shields.io/badge/chat-%23florisboard%3amatrix.org-blue)](https://matrix.to/#/#florisboard:matrix.org) [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md) [![FlorisBoard CI](https://github.com/florisboard/florisboard/actions/workflows/android.yml/badge.svg?event=push)](https://github.com/florisboard/florisboard/actions/workflows/android.yml)

**FlorisBoard** is a free and open-source keyboard for Android 8.0+
devices. It aims at being modern, user-friendly and customizable while
fully respecting your privacy. Currently in beta state.

<table>
<tr>
<th style="text-align: center; width: 50%">
<h3>Stable <a href="https://github.com/florisboard/florisboard/releases/latest"><img alt="Latest stable release" src="https://img.shields.io/github/v/release/florisboard/florisboard?sort=semver&display_name=tag&color=28a745"></a></h3>
</th>
<th style="text-align: center; width: 50%">
<h3>Preview <a href="https://github.com/florisboard/florisboard/releases"><img alt="Latest preview release" src="https://img.shields.io/github/v/release/florisboard/florisboard?include_prereleases&sort=semver&display_name=tag&color=fd7e14"></a></h3>
</th>
</tr>
<tr>
<td style="vertical-align: top">
<p><i>Major versions only</i><br><br>Updates are more polished, new features are matured and tested through to ensure a stable experience.</p>
</td>
<td style="vertical-align: top">
<p><i>Major + Alpha/Beta/Rc versions</i><br><br>Updates contain new features that may not be fully matured yet and bugs are more likely to occur. Allows you to give early feedback.</p>
</td>
</tr>
<tr>
<td style="vertical-align: top">
<p>
<a href="https://apt.izzysoft.de/fdroid/index/apk/dev.patrickgold.florisboard"><img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" height="64" alt="IzzySoft repo badge"></a>
<a href="https://f-droid.org/packages/dev.patrickgold.florisboard"><img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png" height="64" alt="F-Droid badge"></a>
</p>
<p>

**Google Play**: Join the [FlorisBoard Test Group](https://groups.google.com/g/florisboard-closed-beta-test), then visit the [testing page](https://play.google.com/apps/testing/dev.patrickgold.florisboard). Once joined and installed, updates will be delivered like for any other app. ([Store entry](https://play.google.com/store/apps/details?id=dev.patrickgold.florisboard))

</p>
<p>

**Obtainium**: [Auto-import stable config][obtainium_stable]

</p>
<p>

**Manual**: Download and install the APK from the release page.

</p>
</td>
<td style="vertical-align: top">
<p><a href="https://apt.izzysoft.de/fdroid/index/apk/dev.patrickgold.florisboard.beta"><img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" height="64" alt="IzzySoft repo badge"></a></p>
<p>

**Google Play**: Join the [FlorisBoard Test Group](https://groups.google.com/g/florisboard-closed-beta-test), then visit the [preview testing page](https://play.google.com/apps/testing/dev.patrickgold.florisboard.beta). Once joined and installed, updates will be delivered like for any other app. ([Store entry](https://play.google.com/store/apps/details?id=dev.patrickgold.florisboard.beta))

</p>
<p>

**Obtainium**: [Auto-import preview config][obtainium_preview]

</p>
<p>

**Manual**: Download and install the APK from the release page.

</p>
</td>
</tr>
</table>

Beginning with v0.7 FlorisBoard will enter the public beta on Google Play.

## Highlighted features
- Integrated clipboard manager / history
- Advanced theming support and customization
- Integrated extension support (still evolving)
- Emoji keyboard / history / suggestions

> [!IMPORTANT]
> Word suggestions/spell checking are not included in the current releases
> and are a major goal for the v0.6 milestone.

Feature roadmap: See [ROADMAP.md](ROADMAP.md)

## Contributing
Want to contribute to FlorisBoard? That's great to hear! There are lots of
different ways to help out, please see the [contribution guidelines](CONTRIBUTING.md) for more info.

## Building and deploying locally

### Prerequisites

| Tool | Required version |
|------|-----------------|
| JDK | 17 |
| Android SDK (compile) | API 36 |
| Android NDK | 29.0.14206865 |
| CMake | 3.22+ (4.1.2 recommended) |
| Clang | 15+ |
| Rust / rustup | 1.28.2+ (toolchain 1.93.0) |
| Git | any recent version |

The easiest way to get the Android SDK and NDK is through **Android Studio** (or IntelliJ IDEA with the Android + Compose plugins). Rust can be installed via [rustup](https://www.rust-lang.org/tools/install).

> [!NOTE]
> IntelliJ IDEA users must enable **Future AGP Versions** support for AGP 9.0.0 to work.
> See [this YouTrack comment](https://youtrack.jetbrains.com/issue/IDEA-348937/2024.1-Beta-missing-option-to-enable-sync-with-future-AGP-versions#focus=Comments-27-11721710.0-0) for instructions.

### Clone the repository

```bash
git clone https://github.com/florisboard/florisboard.git
cd florisboard
```

### Build a debug APK (development / sideload)

```bash
./gradlew assembleDebug
```

The resulting APK is written to:

```
app/build/outputs/apk/debug/app-debug.apk
```

> [!NOTE]
> The debug build appends `.debug` to the application ID (`dev.patrickgold.florisboard.debug`), so it installs alongside the release version without conflicts.

### Build a release APK

Unsigned (for local testing):

```bash
./gradlew assembleRelease
```

To sign the APK, configure a keystore in `app/build.gradle.kts` or pass signing properties on the command line, then run the same command. The output is at:

```
app/build/outputs/apk/release/app-release.apk
```

### Install directly to a connected device / emulator

A convenience script is included that builds the debug APK and installs it in one step:

```bash
./deploy.sh
```

The script will error clearly if no device is connected, or if multiple devices are attached (set `ANDROID_SERIAL` to disambiguate in that case).

Alternatively, run the Gradle task directly:

```bash
./gradlew installDebug
```

Verify the installation succeeded:

```bash
adb shell pm list packages | grep florisboard
```

### Enable FlorisBoard after installation

1. Open **Settings → System → Language & Input → On-screen keyboard** (path may vary by manufacturer).
2. Enable **FlorisBoard** in the keyboard list.
3. Switch to FlorisBoard from the keyboard selector in any text field.

### Run unit tests

```bash
./gradlew test
```

### Clean the build

```bash
./gradlew clean
```

## Addons Store
The official [Addons Store](https://beta.addons.florisboard.org) offers the possibility for the community to share and download FlorisBoard extensions.
Instructions on how to publish addons can be found [here](https://github.com/florisboard/florisboard/wiki/How-to-publish-on-FlorisBoard-Addons).

Many thanks to Ali ([@4H1R](https://github.com/4H1R)) for implementing the store!

> [!NOTE]
> During the initial beta release phase, the Addons Store _will_ only accept theme extensions.
> Later on we plan to add support for language packs and keyboard extensions.

## List of permissions FlorisBoard requests
Please refer to this [page](https://github.com/florisboard/florisboard/wiki/List-of-permissions-FlorisBoard-requests)
to get more information on this topic.

## APK signing certificate hashes

The package names and SHA-256 hashes of the signature certificate are listed below, so you can verify both FlorisBoard variants with apksigner by using `apksigner verify --print-certs florisboard-<version>-<track>.apk` when you download the APK.
If you have [AppVerifier](https://github.com/soupslurpr/AppVerifier) installed, you can alternatively copy both the package name and the hash of the corresponding track and share them to AppVerifier.

##### Stable track:

dev.patrickgold.florisboard<br>
0B:80:71:64:50:8E:AF:EB:1F:BB:81:5B:E7:A2:3C:77:FE:68:9D:94:B1:43:75:C9:9B:DA:A9:B6:57:7F:D6:D6

##### Preview track:

dev.patrickgold.florisboard.beta<br>
0B:80:71:64:50:8E:AF:EB:1F:BB:81:5B:E7:A2:3C:77:FE:68:9D:94:B1:43:75:C9:9B:DA:A9:B6:57:7F:D6:D6


## Used libraries, components and icons
* [AndroidX libraries](https://github.com/androidx/androidx) by
  [Android Jetpack](https://github.com/androidx)
* [AboutLibraries](https://github.com/mikepenz/AboutLibraries) by
  [mikepenz](https://github.com/mikepenz)
* [Google Material icons](https://github.com/google/material-design-icons) by
  [Google](https://github.com/google)
* [JetPref preference library](https://github.com/patrickgold/jetpref) by
  [patrickgold](https://github.com/patrickgold)
* [KotlinX coroutines library](https://github.com/Kotlin/kotlinx.coroutines) by
  [Kotlin](https://github.com/Kotlin)
* [KotlinX serialization library](https://github.com/Kotlin/kotlinx.serialization) by
  [Kotlin](https://github.com/Kotlin)

Many thanks to [Nikolay Anzarov](https://www.behance.net/nikolayanzarov) ([@BloodRaven0](https://github.com/BloodRaven0)) for designing and providing the main app icons to this project!

## License
```
Copyright 2020-2026 The FlorisBoard Contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

Thanks to [The FlorisBoard Contributors](https://github.com/florisboard/florisboard/graphs/contributors) for making this project possible!

<!-- BEGIN SECTION: obtainium_links -->
<!-- auto-generated link templates, do NOT edit by hand -->
<!-- see fastlane/update-readme.sh -->
[obtainium_preview]: https://apps.obtainium.imranr.dev/redirect.html?r=obtainium://app/%7B%22id%22%3A%22dev.patrickgold.florisboard.beta%22%2C%22url%22%3A%22https%3A%2F%2Fgithub.com%2Fflorisboard%2Fflorisboard%22%2C%22author%22%3A%22florisboard%22%2C%22name%22%3A%22FlorisBoard%20Preview%22%2C%22additionalSettings%22%3A%22%7B%5C%22includePrereleases%5C%22%3Atrue%2C%5C%22fallbackToOlderReleases%5C%22%3Atrue%2C%5C%22apkFilterRegEx%5C%22%3A%5C%22preview%5C%22%7D%22%7D%0A
[obtainium_stable]: https://apps.obtainium.imranr.dev/redirect.html?r=obtainium://app/%7B%22id%22%3A%22dev.patrickgold.florisboard%22%2C%22url%22%3A%22https%3A%2F%2Fgithub.com%2Fflorisboard%2Fflorisboard%22%2C%22author%22%3A%22florisboard%22%2C%22name%22%3A%22FlorisBoard%20Stable%22%2C%22additionalSettings%22%3A%22%7B%5C%22includePrereleases%5C%22%3Afalse%2C%5C%22fallbackToOlderReleases%5C%22%3Atrue%2C%5C%22apkFilterRegEx%5C%22%3A%5C%22stable%5C%22%7D%22%7D%0A
<!-- END SECTION: obtainium_links -->
