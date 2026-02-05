# Mariners Countdown Widget

iOS app with home screen widget showing countdown to the Mariners' first spring training game on February 20, 2026 at 12:10 PM PT.

## Setup

1. **Open in Xcode**
   ```bash
   open MarinersCountdown.xcodeproj
   ```

2. **Configure Code Signing**
   - Select the "MarinersCountdown" project in the navigator
   - Select "MarinersCountdown" target
   - Go to "Signing & Capabilities"
   - Set your Team (requires Apple Developer account)
   - Xcode will automatically update the bundle identifier if needed
   - Repeat for "MarinersWidgetExtension" target

3. **Connect Your iPhone**
   - Connect your iPhone via USB
   - Unlock the device and trust your computer if prompted
   - Select your device from the device menu in Xcode toolbar

4. **Build and Run**
   - Click the Run button (▶) or press Cmd+R
   - The app will install on your iPhone
   - Grant any permissions if prompted

## Using the Widget

1. Long-press on your home screen
2. Tap the "+" button in the top-left corner
3. Search for "Mariners"
4. Select "Mariners Countdown"
5. Choose the small widget size
6. Tap "Add Widget"

The widget will show the number of days until the game and updates daily at midnight.

## Command-Line Build (Optional)

If you prefer to build from command line after initial setup:

```bash
# Build the app
xcodebuild -project MarinersCountdown.xcodeproj \
  -scheme MarinersCountdown \
  -configuration Debug \
  -destination 'platform=iOS,name=YOUR_IPHONE_NAME' \
  build

# Or use ios-deploy to install
# brew install ios-deploy
xcodebuild -project MarinersCountdown.xcodeproj \
  -scheme MarinersCountdown \
  -configuration Debug \
  -sdk iphoneos \
  -derivedDataPath build \
  build

ios-deploy --bundle build/Build/Products/Debug-iphoneos/MarinersCountdown.app
```

Replace `YOUR_IPHONE_NAME` with your device name as shown in Xcode.

## Features

- **Small widget** showing countdown in days
- **Game Day display** shows "🎉 Game Day!" on February 20, 2026
- **Daily updates** at midnight
- **Pacific Time** timezone handling for accurate countdown
- **Mariners branding** with team colors

## Project Structure

- `MarinersCountdown/` - Main iOS app
- `MarinersWidget/` - Widget extension
- `Shared/` - Shared countdown logic between app and widget

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Apple Developer account for device installation
