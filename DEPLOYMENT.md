# Deployment Guide

## Quick Start - Deploy to Your iPhone

### Option 1: Using Xcode (Recommended for First Time)

1. **Open the project:**
   ```bash
   open MarinersCountdown.xcodeproj
   ```

2. **Configure your team:**
   - Click on "MarinersCountdown" in the left sidebar
   - Select the "MarinersCountdown" target
   - Click on "Signing & Capabilities" tab
   - Under "Signing", select your Team from the dropdown
   - Xcode will automatically manage signing and provisioning
   - Repeat for "MarinersWidgetExtension" target

3. **Connect your iPhone:**
   - Plug in your iPhone via USB
   - Unlock it and tap "Trust This Computer" if prompted
   - In Xcode, click the device menu next to the Run button
   - Select your iPhone from the list

4. **Run the app:**
   - Click the Run button (▶) or press `Cmd+R`
   - Wait for build to complete
   - The app will automatically install and launch on your iPhone
   - If you see a "Developer Mode" alert, go to Settings > Privacy & Security > Developer Mode and enable it

5. **Add the widget:**
   - On your iPhone home screen, long-press an empty area
   - Tap the "+" button in the top-left
   - Search for "Mariners"
   - Select "Mariners Countdown" widget
   - Choose Small size
   - Tap "Add Widget"
   - Position it where you want

### Option 2: Command Line Build & Deploy

After initial Xcode setup (for code signing):

```bash
# Navigate to project directory
cd /Users/jameshart/workspace/countdown-widget-ios

# List available devices
xcrun xctrace list devices

# Build and install (replace YOUR_DEVICE_NAME with your iPhone name)
xcodebuild -project MarinersCountdown.xcodeproj \
  -scheme MarinersCountdown \
  -configuration Debug \
  -destination 'platform=iOS,name=YOUR_DEVICE_NAME' \
  clean build

# Alternative: Build and use ios-deploy
# First install ios-deploy: brew install ios-deploy
xcodebuild -project MarinersCountdown.xcodeproj \
  -scheme MarinersCountdown \
  -configuration Debug \
  -sdk iphoneos \
  -derivedDataPath ./build \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO \
  build

# Then install with ios-deploy
ios-deploy --bundle ./build/Build/Products/Debug-iphoneos/MarinersCountdown.app
```

**Note:** Code signing via command line requires additional setup. For simplicity, use Xcode GUI for the initial build to configure signing automatically.

## Troubleshooting

### "Untrusted Developer" message on iPhone
- Go to Settings > General > VPN & Device Management
- Tap on your developer certificate
- Tap "Trust [Your Name]"

### Build fails with signing error
- Make sure you've selected your Team in both targets (app and widget extension)
- Ensure bundle identifiers are unique (Xcode should auto-generate these)
- Check that your Apple Developer account is active

### Widget doesn't appear in widget gallery
- Make sure the app built successfully
- Try restarting your iPhone
- Check that both targets (app and extension) have correct code signing

### Widget shows placeholder or doesn't update
- The widget updates at midnight Pacific Time
- iOS may delay updates to preserve battery
- Try removing and re-adding the widget

## Updating the App

To update the app on your device after making changes:

1. Make your code changes
2. Connect your iPhone
3. In Xcode, click Run (or use command line build)
4. The updated app will automatically replace the old one

The widget will automatically reflect any changes to the shared countdown logic.

## Command Line Workflow

Once Xcode has configured signing:

```bash
# Check available devices
xcrun xctrace list devices

# Build for device (quick check)
xcodebuild -project MarinersCountdown.xcodeproj \
  -scheme MarinersCountdown \
  -destination 'generic/platform=iOS' \
  clean build

# Build and run tests (if you add them later)
xcodebuild test -project MarinersCountdown.xcodeproj \
  -scheme MarinersCountdown \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

## What Happens on February 20, 2026?

The widget will show "🎉 Game Day!" instead of the countdown number. After that date, it will show "0 days" (since the game has passed).

## Next Steps

After the app is working on your phone:

1. **Customize appearance** - Edit colors in the widget view
2. **Add more games** - Extend the countdown calculator for multiple dates
3. **Support multiple sizes** - Add medium/large widget layouts
4. **Add complications** - Support for Apple Watch if desired

Enjoy your Mariners countdown! ⚾
