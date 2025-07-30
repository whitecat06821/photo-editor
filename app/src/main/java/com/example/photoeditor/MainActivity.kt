package com.example.photoeditor

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.*
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.view.View
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.photoeditor.databinding.ActivityMainBinding
import jp.co.cyberagent.android.gpuimage.GPUImage
import jp.co.cyberagent.android.gpuimage.filter.GPUImageGrayscaleFilter
import java.io.File
import java.io.FileOutputStream

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private var currentBitmap: Bitmap? = null
    private var gpuImage: GPUImage? = null
    private var isGrayscaleApplied = false

    // Permission launcher
    private val permissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { isGranted ->
        if (isGranted) {
            openGallery()
        } else {
            showPermissionDeniedDialog()
        }
    }

    // Gallery launcher
    private val galleryLauncher = registerForActivityResult(
        ActivityResultContracts.GetContent()
    ) { uri ->
        uri?.let { loadImageFromUri(it) }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupUI()
        checkAndRequestPermissions()
    }

    private fun setupUI() {
        // Set up click listeners
        binding.selectImageButton.setOnClickListener { checkPermissionAndOpenGallery() }
        binding.imageContainer.setOnClickListener { checkPermissionAndOpenGallery() }
        binding.filterButton.setOnClickListener { applyGrayscaleFilter() }
        binding.textButton.setOnClickListener { showTextInput() }
        binding.drawingButton.setOnClickListener { toggleDrawingMode() }
        binding.addTextButton.setOnClickListener { addTextToImage() }
        binding.cancelTextButton.setOnClickListener { hideTextInput() }
        binding.clearDrawingButton.setOnClickListener { clearDrawing() }
        binding.exitDrawingButton.setOnClickListener { exitDrawingMode() }
        binding.saveButton.setOnClickListener { saveImage() }
        binding.shareButton.setOnClickListener { shareImage() }
        binding.exportButton.setOnClickListener { exportImage() }

        // Initialize GPUImage
        gpuImage = GPUImage(this)
    }

    private fun checkAndRequestPermissions() {
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_EXTERNAL_STORAGE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            showPermissionDialog()
        }
    }

    private fun showPermissionDialog() {
        AlertDialog.Builder(this)
            .setTitle("Photo Access Required")
            .setMessage("This app needs access to your photos to edit them. Please grant permission to continue.")
            .setPositiveButton("Grant Permission") { _, _ ->
                permissionLauncher.launch(Manifest.permission.READ_EXTERNAL_STORAGE)
            }
            .setNegativeButton("Cancel") { dialog, _ ->
                dialog.dismiss()
                Toast.makeText(this, "Permission required to use the app", Toast.LENGTH_LONG).show()
            }
            .setCancelable(false)
            .show()
    }

    private fun showPermissionDeniedDialog() {
        AlertDialog.Builder(this)
            .setTitle("Permission Denied")
            .setMessage("Photo access is required for this app to work. Please grant permission in Settings.")
            .setPositiveButton("Open Settings") { _, _ ->
                // Open app settings
                val intent = Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                intent.data = Uri.fromParts("package", packageName, null)
                startActivity(intent)
            }
            .setNegativeButton("Cancel") { dialog, _ ->
                dialog.dismiss()
            }
            .show()
    }

    private fun checkPermissionAndOpenGallery() {
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_EXTERNAL_STORAGE
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            openGallery()
        } else {
            permissionLauncher.launch(Manifest.permission.READ_EXTERNAL_STORAGE)
        }
    }

    private fun openGallery() {
        galleryLauncher.launch("image/*")
    }

    private fun loadImageFromUri(uri: Uri) {
        try {
            val inputStream = contentResolver.openInputStream(uri)
            val bitmap = BitmapFactory.decodeStream(inputStream)
            inputStream?.close()

            currentBitmap = bitmap
            binding.imageView.setImageBitmap(bitmap)
            binding.placeholderLayout.visibility = View.GONE
            binding.imageView.visibility = View.VISIBLE

            // Reset states
            isGrayscaleApplied = false
            binding.drawingView.clearDrawing()
            binding.drawingView.visibility = View.GONE

            Toast.makeText(this, "Image loaded successfully!", Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            Toast.makeText(this, "Error loading image: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }

    private fun applyGrayscaleFilter() {
        currentBitmap?.let { bitmap ->
            if (!isGrayscaleApplied) {
                gpuImage?.setImage(bitmap)
                gpuImage?.setFilter(GPUImageGrayscaleFilter())
                val filteredBitmap = gpuImage?.bitmapWithFilterApplied
                filteredBitmap?.let {
                    currentBitmap = it
                    binding.imageView.setImageBitmap(it)
                    isGrayscaleApplied = true
                    Toast.makeText(this, "Grayscale filter applied!", Toast.LENGTH_SHORT).show()
                }
            } else {
                // Remove filter
                currentBitmap = bitmap
                binding.imageView.setImageBitmap(bitmap)
                isGrayscaleApplied = false
                Toast.makeText(this, "Filter removed!", Toast.LENGTH_SHORT).show()
            }
        } ?: run {
            Toast.makeText(this, "Please select an image first", Toast.LENGTH_SHORT).show()
        }
    }

    private fun showTextInput() {
        if (currentBitmap == null) {
            Toast.makeText(this, "Please select an image first", Toast.LENGTH_SHORT).show()
            return
        }
        binding.textInputLayout.visibility = View.VISIBLE
        binding.textInput.requestFocus()
    }

    private fun hideTextInput() {
        binding.textInputLayout.visibility = View.GONE
        binding.textInput.text?.clear()
    }

    private fun addTextToImage() {
        val text = binding.textInput.text.toString()
        if (text.isEmpty()) {
            Toast.makeText(this, "Please enter some text", Toast.LENGTH_SHORT).show()
            return
        }

        currentBitmap?.let { bitmap ->
            val mutableBitmap = bitmap.copy(Bitmap.Config.ARGB_8888, true)
            val canvas = Canvas(mutableBitmap)
            val paint = Paint().apply {
                color = Color.WHITE
                textSize = 60f
                isAntiAlias = true
                setShadowLayer(3f, 2f, 2f, Color.BLACK)
            }

            // Calculate text position (center of image)
            val textBounds = Rect()
            paint.getTextBounds(text, 0, text.length, textBounds)
            val x = (bitmap.width - textBounds.width()) / 2f
            val y = (bitmap.height + textBounds.height()) / 2f

            canvas.drawText(text, x, y, paint)
            currentBitmap = mutableBitmap
            binding.imageView.setImageBitmap(mutableBitmap)
            hideTextInput()
            Toast.makeText(this, "Text added to image!", Toast.LENGTH_SHORT).show()
        }
    }

    private fun toggleDrawingMode() {
        if (currentBitmap == null) {
            Toast.makeText(this, "Please select an image first", Toast.LENGTH_SHORT).show()
            return
        }

        if (binding.drawingView.visibility == View.VISIBLE) {
            exitDrawingMode()
        } else {
            binding.drawingView.visibility = View.VISIBLE
            binding.drawingControlsLayout.visibility = View.VISIBLE
            Toast.makeText(this, "Drawing mode activated! Draw on the image", Toast.LENGTH_SHORT).show()
        }
    }

    private fun exitDrawingMode() {
        binding.drawingView.visibility = View.GONE
        binding.drawingControlsLayout.visibility = View.GONE
        Toast.makeText(this, "Drawing mode deactivated", Toast.LENGTH_SHORT).show()
    }

    private fun clearDrawing() {
        binding.drawingView.clearDrawing()
        Toast.makeText(this, "Drawing cleared!", Toast.LENGTH_SHORT).show()
    }

    private fun saveImage() {
        currentBitmap?.let { bitmap ->
            try {
                // Combine bitmap with drawing if in drawing mode
                val finalBitmap = if (binding.drawingView.visibility == View.VISIBLE) {
                    combineBitmapWithDrawing(bitmap)
                } else {
                    bitmap
                }

                val fileName = "PhotoEditor_${System.currentTimeMillis()}.jpg"
                val file = File(getExternalFilesDir(null), fileName)
                val outputStream = FileOutputStream(file)
                finalBitmap.compress(Bitmap.CompressFormat.JPEG, 90, outputStream)
                outputStream.close()

                Toast.makeText(this, "Image saved to: ${file.absolutePath}", Toast.LENGTH_LONG).show()
            } catch (e: Exception) {
                Toast.makeText(this, "Error saving image: ${e.message}", Toast.LENGTH_SHORT).show()
            }
        } ?: run {
            Toast.makeText(this, "No image to save", Toast.LENGTH_SHORT).show()
        }
    }

    private fun combineBitmapWithDrawing(originalBitmap: Bitmap): Bitmap {
        val combinedBitmap = originalBitmap.copy(Bitmap.Config.ARGB_8888, true)
        val canvas = Canvas(combinedBitmap)
        val drawingBitmap = binding.drawingView.getDrawingBitmap()
        if (drawingBitmap != null) {
            canvas.drawBitmap(drawingBitmap, 0f, 0f, null)
        }
        return combinedBitmap
    }

    private fun shareImage() {
        currentBitmap?.let { bitmap ->
            try {
                val finalBitmap = if (binding.drawingView.visibility == View.VISIBLE) {
                    combineBitmapWithDrawing(bitmap)
                } else {
                    bitmap
                }

                val fileName = "PhotoEditor_${System.currentTimeMillis()}.jpg"
                val file = File(getExternalFilesDir(null), fileName)
                val outputStream = FileOutputStream(file)
                finalBitmap.compress(Bitmap.CompressFormat.JPEG, 90, outputStream)
                outputStream.close()

                val uri = Uri.fromFile(file)
                val shareIntent = Intent(Intent.ACTION_SEND).apply {
                    type = "image/jpeg"
                    putExtra(Intent.EXTRA_STREAM, uri)
                    putExtra(Intent.EXTRA_TEXT, "Check out my edited photo!")
                    addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                }
                startActivity(Intent.createChooser(shareIntent, "Share Image"))
            } catch (e: Exception) {
                Toast.makeText(this, "Error sharing image: ${e.message}", Toast.LENGTH_SHORT).show()
            }
        } ?: run {
            Toast.makeText(this, "No image to share", Toast.LENGTH_SHORT).show()
        }
    }

    private fun exportImage() {
        saveImage() // Export is same as save for now
    }
} 