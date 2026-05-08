#!/usr/bin/env bash
set -euo pipefail

# -- Environment setup -------------------------------------------------------
export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/java-17-openjdk-amd64}"
export ANDROID_HOME="${ANDROID_HOME:-$HOME/Android/Sdk}"
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$HOME/.cargo/bin:/usr/bin:/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -- Pre-flight: require a connected device ----------------------------------
device_count=$(adb devices | tail -n +2 | grep -c 'device$' || true)

if [[ "$device_count" -eq 0 ]]; then
    echo "ERROR: No ADB device/emulator detected. Connect a device or start an emulator and retry." >&2
    exit 1
fi

if [[ "$device_count" -gt 1 ]] && [[ -z "${ANDROID_SERIAL:-}" ]]; then
    echo "ERROR: Multiple devices detected. Set ANDROID_SERIAL to the target device serial and retry." >&2
    adb devices
    exit 1
fi

# -- Build -------------------------------------------------------------------
echo "==> Building debug APK..."
"$SCRIPT_DIR/gradlew" clean assembleDebug

APK="$SCRIPT_DIR/app/build/outputs/apk/debug/app-debug.apk"

if [[ ! -f "$APK" ]]; then
    echo "ERROR: Expected APK not found at $APK" >&2
    exit 1
fi

# -- Install -----------------------------------------------------------------
echo "==> Installing $(basename "$APK") on device..."
adb ${ANDROID_SERIAL:+-s "$ANDROID_SERIAL"} install -r "$APK"

echo ""
echo "Done. FlorisBoard debug build installed successfully."
echo "Go to Settings → System → Language & Input → On-screen keyboard to enable it."
