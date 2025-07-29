package com.example.photoeditor

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.*
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.photoeditor.databinding.ActivityMainBinding
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class MainActivity : AppCompatActivity() {
    
    private lateinit var binding: ActivityMainBinding
    private var originalBitmap: Bitmap? = null
    private var currentBitmap: Bitmap? = null
    private var isGrayscaleApplied = false
    
    private val selectImageLauncher = registerForActivityResult(
        ActivityResultContracts.GetContent()
    ) { uri: Uri? ->
        uri?.let { loadImageFromUri(it) }
    }
    
    private val requestPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { isGranted: Boolean ->
        if (isGranted) {
            openImagePicker()
        } else {
            Toast.makeText(this, "Permission denied", Toast.LENGTH_SHORT).show()
        }
    }
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        
        setupClickListeners()
    }
    
    private fun setupClickListeners() {
        binding.selectImageButton.setOnClickListener {
            checkPermissionAndSelectImage()
        }
        
        binding.grayscaleButton.setOnClickListener {
            applyGrayscaleFilter()
        }
        
        binding.addTextButton.setOnClickListener {
            addTextOverlay()
        }
        
        binding.saveButton.setOnClickListener {
            saveImage()
        }
    }
    
    private fun checkPermissionAndSelectImage() {
        when {
            ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_EXTERNAL_STORAGE
            ) == PackageManager.PERMISSION_GRANTED -> {
                openImagePicker()
            }
            shouldShowRequestPermissionRationale(Manifest.permission.READ_EXTERNAL_STORAGE) -> {
                Toast.makeText(this, "Storage permission is required", Toast.LENGTH_LONG).show()
            }
            else -> {
                requestPermissionLauncher.launch(Manifest.permission.READ_EXTERNAL_STORAGE)
            }
        }
    }
    
    private fun openImagePicker() {
        selectImageLauncher.launch("image/*")
    }
    
    private fun loadImageFromUri(uri: Uri) {
        try {
            val inputStream = contentResolver.openInputStream(uri)
            originalBitmap = BitmapFactory.decodeStream(inputStream)
            currentBitmap = originalBitmap?.copy(Bitmap.Config.ARGB_8888, true)
            
            binding.imageView.setImageBitmap(currentBitmap)
            isGrayscaleApplied = false
            
            Toast.makeText(this, "Image loaded successfully", Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            Toast.makeText(this, "Error loading image: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }
    
    private fun applyGrayscaleFilter() {
        if (currentBitmap == null) {
            Toast.makeText(this, "Please select an image first", Toast.LENGTH_SHORT).show()
            return
        }
        
        try {
            val width = currentBitmap!!.width
            val height = currentBitmap!!.height
            val grayscaleBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            
            val canvas = Canvas(grayscaleBitmap)
            val paint = Paint()
            val colorMatrix = ColorMatrix()
            colorMatrix.setSaturation(0f) // 0 = grayscale
            paint.colorFilter = ColorMatrixColorFilter(colorMatrix)
            
            canvas.drawBitmap(currentBitmap!!, 0f, 0f, paint)
            
            currentBitmap = grayscaleBitmap
            binding.imageView.setImageBitmap(currentBitmap)
            isGrayscaleApplied = true
            
            Toast.makeText(this, "Grayscale filter applied", Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            Toast.makeText(this, "Error applying grayscale filter: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }
    
    private fun addTextOverlay() {
        val text = binding.textInput.text.toString().trim()
        if (text.isEmpty()) {
            Toast.makeText(this, "Please enter some text", Toast.LENGTH_SHORT).show()
            return
        }
        
        if (currentBitmap == null) {
            Toast.makeText(this, "Please select an image first", Toast.LENGTH_SHORT).show()
            return
        }
        
        try {
            val width = currentBitmap!!.width
            val height = currentBitmap!!.height
            val textBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            
            val canvas = Canvas(textBitmap)
            canvas.drawBitmap(currentBitmap!!, 0f, 0f, null)
            
            val paint = Paint().apply {
                color = Color.WHITE
                textSize = 60f
                isAntiAlias = true
                setShadowLayer(3f, 1f, 1f, Color.BLACK)
            }
            
            val textBounds = Rect()
            paint.getTextBounds(text, 0, text.length, textBounds)
            
            val x = (width - textBounds.width()) / 2f
            val y = height - 100f // Position text near bottom
            
            canvas.drawText(text, x, y, paint)
            
            currentBitmap = textBitmap
            binding.imageView.setImageBitmap(currentBitmap)
            
            Toast.makeText(this, "Text overlay added", Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            Toast.makeText(this, "Error adding text overlay: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }
    
    private fun saveImage() {
        if (currentBitmap == null) {
            Toast.makeText(this, "No image to save", Toast.LENGTH_SHORT).show()
            return
        }
        
        try {
            val imagesDir = File(getExternalFilesDir(null), "PhotoEditor")
            if (!imagesDir.exists()) {
                imagesDir.mkdirs()
            }
            
            val fileName = "edited_image_${System.currentTimeMillis()}.jpg"
            val imageFile = File(imagesDir, fileName)
            
            val outputStream = FileOutputStream(imageFile)
            currentBitmap!!.compress(Bitmap.CompressFormat.JPEG, 90, outputStream)
            outputStream.close()
            
            Toast.makeText(
                this,
                "Image saved to: ${imageFile.absolutePath}",
                Toast.LENGTH_LONG
            ).show()
        } catch (e: IOException) {
            Toast.makeText(this, "Error saving image: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }
} 