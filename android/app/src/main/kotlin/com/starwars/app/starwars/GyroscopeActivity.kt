package com.starwars.app.starwars

import android.annotation.TargetApi
import android.content.Context.SENSOR_SERVICE
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.math.atan2

open class GyroscopeActivity : FlutterActivity(), SensorEventListener {

    private lateinit var sensorManager: SensorManager
    private lateinit var sensor: Sensor
    private lateinit var channel: MethodChannel

    private var lastUpdate: Long = 0
    private var currentAngle: Float = 0f

    @TargetApi(Build.VERSION_CODES.KITKAT)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "gyroscope")
        channel.setMethodCallHandler { call, result ->
            if (call.method == "getAngle") {
                result.success(currentAngle.toDouble())
            } else {
                result.notImplemented()
            }
        }
        sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
        sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_GAME,
            SensorManager.SENSOR_DELAY_GAME)
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if(event != null){
            if (event.sensor?.type == Sensor.TYPE_ACCELEROMETER) {
                var sensorValues = FloatArray(10)
                sensorValues = lowPass(event.values!!.clone(),sensorValues)
                val x = sensorValues[0]
                val y = sensorValues[1]
                val degreeRotation = atan2(x.toDouble(),y.toDouble())
                val rotation = Math.toDegrees(degreeRotation)
                channel.invokeMethod("gyroData", mapOf("gyroValue" to rotation))
            }
        }
    }

    private fun lowPass(input: FloatArray, output: FloatArray?): FloatArray {
        val alpha = 0.15f
        if (output == null) return input
        for (i in input.indices) {
            output[i] = output[i] + alpha * (input[i] - output[i])
        }
        return output
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    override fun onDestroy() {
        super.onDestroy()
        sensorManager.unregisterListener(this)
    }
}
