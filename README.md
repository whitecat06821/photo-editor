# Photo Editor Android App

A simple Android app built in Kotlin that allows users to:
- Select images from the gallery
- Apply grayscale filters
- Add text overlays to images
- Save edited images

## Features

- **Image Selection**: Choose images from device gallery
- **Grayscale Filter**: Convert images to black and white
- **Text Overlay**: Add custom text with shadow effects
- **Image Saving**: Save edited images to device storage

## Requirements

- Android Studio Arctic Fox or later
- Android SDK 24+ (API level 24)
- Kotlin 1.9.10+

## Setup Instructions

1. **Clone or download the project**
2. **Open in Android Studio**
3. **Sync Gradle files**
4. **Build and run on device or emulator**

## Usage

1. **Launch the app**
2. **Tap "Select Image"** to choose a photo from your gallery
3. **Tap "Apply Grayscale Filter"** to convert the image to black and white
4. **Enter text in the input field** and tap "Add Text Overlay" to add text
5. **Tap "Save Image"** to save the edited image to your device

## Permissions

The app requires the following permissions:
- `READ_EXTERNAL_STORAGE`: To access images from gallery
- `WRITE_EXTERNAL_STORAGE`: To save edited images

## Project Structure

```
app/
├── src/main/
│   ├── java/com/example/photoeditor/
│   │   └── MainActivity.kt          # Main activity with photo editing logic
│   ├── res/
│   │   ├── layout/
│   │   │   └── activity_main.xml    # Main UI layout
│   │   ├── values/
│   │   │   ├── strings.xml          # String resources
│   │   │   ├── colors.xml           # Color definitions
│   │   │   └── themes.xml           # App theme
│   │   └── drawable/
│   │       └── ic_launcher_foreground.xml  # App icon
│   └── AndroidManifest.xml          # App manifest with permissions
└── build.gradle.kts                 # App-level build configuration
```

## Technical Details

- **Language**: Kotlin
- **Architecture**: Single Activity with View Binding
- **Image Processing**: Android Canvas and Paint APIs
- **Permissions**: Runtime permission handling
- **File Operations**: External storage access for saving images

## Dependencies

- AndroidX Core KTX
- AndroidX AppCompat
- Material Design Components
- ConstraintLayout
- Activity KTX for result handling

## Building the App

```bash
# In Android Studio:
# 1. File -> Sync Project with Gradle Files
# 2. Build -> Make Project
# 3. Run -> Run 'app'
```

## Troubleshooting

- **Permission Issues**: Make sure to grant storage permissions when prompted
- **Image Loading Errors**: Check if the selected image is corrupted or too large
- **Save Errors**: Ensure the app has write permission to external storage

## License

This project is for educational purposes. Feel free to modify and extend the functionality. 