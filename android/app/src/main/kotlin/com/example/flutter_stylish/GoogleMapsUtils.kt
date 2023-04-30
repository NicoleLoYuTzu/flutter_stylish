package com.example.flutter_stylish

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.core.content.ContextCompat.startActivity


class GoogleMapsUtils {
    companion object {
        fun openLocationInMaps(context: Context, latitude: Double, longitude: Double) {
            val uri = Uri.parse("geo:$latitude,$longitude")
            val mapIntent = Intent(Intent.ACTION_VIEW, uri)
            mapIntent.setPackage("com.google.android.apps.maps")
            mapIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            mapIntent.putExtra("123","12345")
            context.startActivity(mapIntent)

        }
    }
}