# Photo Editor Android App

A comprehensive Android app built in Kotlin that allows users to:
- Select images from the gallery
- Apply advanced grayscale filters using GPUImage
- Add text overlays to images
- Draw on images with finger input
- Save edited images with all modifications

## ✨ Features

### 🖼️ **Image Import**
- **Gallery Selection**: Choose images from device gallery with proper permission handling
- **Image Display**: High-quality image display with proper scaling

### 🎨 **Advanced Filtering**
- **GPUImage Integration**: Uses GPUImage library for high-performance image processing
- **Grayscale Filter**: Professional-quality grayscale conversion with GPU acceleration
- **Real-time Processing**: Fast filter application with smooth user experience

### 📝 **Text Overlay**
- **Custom Text Input**: Enter any text to overlay on images
- **Professional Styling**: White text with black shadow for visibility
- **Centered Positioning**: Text automatically centered at the bottom of images

### ✏️ **Drawing Feature**
- **Finger Drawing**: Draw directly on images with touch input
- **Toggle Mode**: Switch between viewing and drawing modes
- **Clear Function**: Remove all drawings with one button
- **Red Stroke**: Default red color for drawing (easily customizable)

### 💾 **Image Saving**
- **Combined Output**: Saves image with all modifications (filters, text, drawings)
- **High Quality**: JPEG format with 90% quality
- **Organized Storage**: Saves to dedicated PhotoEditor folder

## 🛠️ Requirements

- Android Studio Arctic Fox or later
- Android SDK 24+ (API level 24)
- Kotlin 1.9.10+
- GPUImage library for advanced filtering

## 📱 Setup Instructions

1. **Clone or download the project**
2. **Open in Android Studio**
3. **Sync Gradle files** (GPUImage dependency will be downloaded)
4. **Build and run on device or emulator**

## 🎯 Usage Guide

### Basic Workflow:
1. **Launch the app**
2. **Tap "Select Image"** to choose a photo from your gallery
3. **Apply filters** using "Apply Grayscale Filter"
4. **Add text** by entering text and tapping "Add Text Overlay"
5. **Draw on image** by tapping "Toggle Drawing Mode" and drawing with your finger
6. **Save the result** by tapping "Save Image"

### Drawing Mode:
- **Enable**: Tap "Toggle Drawing Mode" button
- **Draw**: Use your finger to draw on the image
- **Clear**: Tap "Clear Drawing" to remove all drawings
- **Exit**: Tap "Exit Drawing Mode" to return to normal view

## 🔐 Permissions

The app requires the following permissions:
- `READ_EXTERNAL_STORAGE`: To access images from gallery
- `WRITE_EXTERNAL_STORAGE`: To save edited images

## 🏗️ Project Structure

```
app/
├── src/main/
│   ├── java/com/example/photoeditor/
│   │   ├── MainActivity.kt          # Main activity with all features
│   │   └── DrawingView.kt           # Custom drawing view
│   ├── res/
│   │   ├── layout/
│   │   │   └── activity_main.xml    # Enhanced UI layout
│   │   ├── values/
│   │   │   ├── strings.xml          # String resources
│   │   │   ├── colors.xml           # Color definitions
│   │   │   └── themes.xml           # App theme
│   │   └── drawable/
│   │       └── ic_launcher_foreground.xml  # App icon
│   └── AndroidManifest.xml          # App manifest with permissions
└── build.gradle.kts                 # App-level build configuration
```

## 🧰 Technical Details

### **Core Technologies:**
- **Language**: Kotlin
- **Architecture**: Single Activity with View Binding
- **Image Processing**: GPUImage library for advanced filtering
- **Drawing**: Custom DrawingView with touch input handling
- **Permissions**: Runtime permission handling
- **File Operations**: External storage access for saving images

### **Key Libraries:**
- **GPUImage**: High-performance image filtering
- **AndroidX Core KTX**: Modern Android development
- **Material Design**: Beautiful UI components
- **ConstraintLayout**: Flexible layouts
- **Activity KTX**: Result handling

## 🚀 Building the App

```bash
# In Android Studio:
# 1. File -> Sync Project with Gradle Files
# 2. Build -> Make Project
# 3. Run -> Run 'app'
```

## 🔧 Customization

### Drawing Features:
- **Color**: Modify `paint.color` in `DrawingView.kt`
- **Stroke Width**: Change `paint.strokeWidth` for different line thickness
- **Drawing Style**: Adjust paint properties for different effects

### Text Overlay:
- **Position**: Modify `x` and `y` coordinates in `addTextOverlay()`
- **Style**: Change paint properties for different text appearance
- **Size**: Adjust `textSize` for different text sizes

## 🐛 Troubleshooting

- **Permission Issues**: Make sure to grant storage permissions when prompted
- **Image Loading Errors**: Check if the selected image is corrupted or too large
- **GPUImage Errors**: Ensure device supports OpenGL ES 2.0
- **Drawing Issues**: Try clearing drawing and restarting drawing mode
- **Save Errors**: Ensure the app has write permission to external storage

## 📈 Performance Features

- **GPU Acceleration**: GPUImage provides hardware-accelerated filtering
- **Memory Management**: Efficient bitmap handling and cleanup
- **Smooth Drawing**: Optimized touch handling for responsive drawing
- **Quality Preservation**: High-quality image processing and saving

## 📄 License

This project is for educational purposes. Feel free to modify and extend the functionality.

## 🤝 Contributing

Feel free to contribute by:
- Adding more filter options
- Implementing color picker for drawing
- Adding brush size selection
- Creating more text styling options
- Adding image rotation and cropping features 