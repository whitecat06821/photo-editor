package com.example.photoeditor

import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.View

class DrawingView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : View(context, attrs, defStyleAttr) {

    private val paint = Paint().apply {
        color = Color.RED
        strokeWidth = 8f
        style = Paint.Style.STROKE
        strokeJoin = Paint.Join.ROUND
        strokeCap = Paint.Cap.ROUND
        isAntiAlias = true
    }

    private val path = Path()
    private val paths = mutableListOf<Path>()
    private val paints = mutableListOf<Paint>()

    private var lastX = 0f
    private var lastY = 0f

    init {
        // Add initial paint
        addNewPath()
    }

    private fun addNewPath() {
        val newPath = Path()
        val newPaint = Paint(paint)
        paths.add(newPath)
        paints.add(newPaint)
    }

    override fun onTouchEvent(event: MotionEvent): Boolean {
        val x = event.x
        val y = event.y

        when (event.action) {
            MotionEvent.ACTION_DOWN -> {
                path.reset()
                path.moveTo(x, y)
                lastX = x
                lastY = y
                return true
            }
            MotionEvent.ACTION_MOVE -> {
                path.quadTo(lastX, lastY, (x + lastX) / 2, (y + lastY) / 2)
                lastX = x
                lastY = y
                invalidate()
                return true
            }
            MotionEvent.ACTION_UP -> {
                path.lineTo(x, y)
                // Add the current path to the list
                val currentPath = Path(path)
                val currentPaint = Paint(paint)
                paths.add(currentPath)
                paints.add(currentPaint)
                path.reset()
                invalidate()
                return true
            }
        }
        return super.onTouchEvent(event)
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        
        // Draw all saved paths
        for (i in paths.indices) {
            canvas.drawPath(paths[i], paints[i])
        }
        
        // Draw current path
        canvas.drawPath(path, paint)
    }

    fun clearDrawing() {
        paths.clear()
        paints.clear()
        path.reset()
        addNewPath()
        invalidate()
    }

    fun setDrawingColor(color: Int) {
        paint.color = color
    }

    fun setStrokeWidth(width: Float) {
        paint.strokeWidth = width
    }

    fun getDrawingBitmap(): Bitmap? {
        if (width <= 0 || height <= 0) return null
        
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        
        // Draw all paths
        for (i in paths.indices) {
            canvas.drawPath(paths[i], paints[i])
        }
        
        return bitmap
    }
} 