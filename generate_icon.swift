#!/usr/bin/env swift

import AppKit
import Foundation

// Create an S logo icon
func createSLogo(size: CGSize) -> NSBitmapImageRep {
    let rep = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(size.width),
        pixelsHigh: Int(size.height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    )!
    
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
    
    // Navy blue background (Mariners colors)
    NSColor(red: 0.0, green: 0.15, blue: 0.3, alpha: 1.0).setFill()
    NSBezierPath(rect: NSRect(origin: .zero, size: size)).fill()
    
    // White "S" letter
    let fontSize = size.width * 0.7
    let font = NSFont.systemFont(ofSize: fontSize, weight: .bold)
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: NSColor.white
    ]
    
    let text = "S"
    let textSize = text.size(withAttributes: attributes)
    let x = (size.width - textSize.width) / 2
    let y = (size.height - textSize.height) / 2
    
    text.draw(at: NSPoint(x: x, y: y), withAttributes: attributes)
    
    NSGraphicsContext.restoreGraphicsState()
    return rep
}

// Save as PNG
func savePNG(bitmapRep: NSBitmapImageRep, path: String) {
    guard let pngData = bitmapRep.representation(using: .png, properties: [:]) else {
        print("Failed to create PNG data")
        return
    }
    
    try? pngData.write(to: URL(fileURLWithPath: path))
    print("Created: \(path)")
}

// Generate icons for different sizes
let outputDir = "MarinersCountdown/Assets.xcassets/AppIcon.appiconset"

// iOS app icon sizes (actual pixel sizes)
let sizes = [
    ("icon_20pt@2x.png", 40.0),
    ("icon_20pt@3x.png", 60.0),
    ("icon_29pt@2x.png", 58.0),
    ("icon_29pt@3x.png", 87.0),
    ("icon_40pt@2x.png", 80.0),
    ("icon_40pt@3x.png", 120.0),
    ("icon_60pt@2x.png", 120.0),
    ("icon_60pt@3x.png", 180.0),
    ("icon_1024.png", 1024.0)
]

for (filename, size) in sizes {
    let bitmapRep = createSLogo(size: CGSize(width: size, height: size))
    savePNG(bitmapRep: bitmapRep, path: "\(outputDir)/\(filename)")
}

print("\nApp icons generated successfully!")
print("Run the following command to rebuild and install the app:")
print("xcodebuild -project MarinersCountdown.xcodeproj -scheme MarinersCountdown -destination 'platform=iOS,id=00008140-000004AC2633001C' && xcrun devicectl device install app --device 00008140-000004AC2633001C /Users/jameshart/Library/Developer/Xcode/DerivedData/MarinersCountdown-elmeaotapzxrykdaalievzckzbeh/Build/Products/Debug-iphoneos/MarinersCountdown.app")
