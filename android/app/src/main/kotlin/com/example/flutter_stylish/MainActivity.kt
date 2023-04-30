package com.example.flutter_stylish

import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

//    private val CHANNEL = "exampleChannel"
//
//    @Override
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//            .setMethodCallHandler { call, result ->
//                if (call.method.equals("getPlatformString")) {
//                    result.success("Hello from Android")
//                } else {
//                    result.notImplemented()
//                }
//            }

//    }

    private val CHANNEL = "test_tappay"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        Log.d(TAG, "configureFlutterEngine")

        setChannelByCustomDialog(flutterEngine)

    }


    fun setChannelByCustomDialog(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "tappay") {
                    Log.d(TAG, "i got u ^.<")

                    val dialog = PrimeDialog(context, object : PrimeDialog.PrimeDialogListener {
                        override fun onSuccess(prime: String) {
                            Log.d(TAG, "onSuccess, prime=$prime")
                            result.success(prime)
                        }

                        override fun onFailure(error: String) {
                            Log.d(TAG, "onFailure, error=$error")
                            result.success(error)
                        }

                    })

                    dialog.show()

                } else if(call.method == "googleMap"){
                    Log.d(TAG, "googleMap i got u ^.<")

                    if (call.method == "googleMap") {
                        val latitude = call.argument<Double>("latitude")!!
                        val longitude = call.argument<Double>("longitude")!!
                        GoogleMapsUtils.openLocationInMaps(this, latitude, longitude)

                        result.success("Received location data from Flutter")
                    } else {
                        result.notImplemented()
                    }


                }else {
                    Log.d(TAG, "u know nothing ${call.method}")

                    result.error("404", "404", null)
                }

//                result.error("404", "404", null)
            }

    }

    fun setChannelByAlertDialog(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "tappay") {
                    Log.d(TAG, "i got u ^.<")

                    val dialog = MaterialAlertDialogBuilder(context)
                        .setTitle("Dialog")
                        .setMessage("Write your message here. ....")
                        .setPositiveButton("Ok") { _, _ ->

                            result.success("Ok got u")
                        }
                        .setNegativeButton("Cancel") { _, _ ->

                            result.success("Cancel got u")
                        }

                    dialog.show()

                } else {
                    Log.d(TAG, "u know nothing ${call.method}")

                    result.error("404", "404", null)
                }

//                result.error("404", "404", null)
            }

    }

    companion object {
        const val TAG = "anan-android"
    }
}
