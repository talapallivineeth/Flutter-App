package com.example.bizwyapp

import android.annotation.TargetApi
import android.os.Build
import android.os.Bundle
import android.util.Base64
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import javax.crypto.Cipher
import javax.crypto.spec.SecretKeySpec

class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter/MethodChannelDemo"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler {
            call, result ->

            val str:String = call.arguments as String


            result.success(encrypt(str))
        }

    }
    @TargetApi(Build.VERSION_CODES.FROYO)
    fun encrypt(input: String): String? {
        var crypted: ByteArray? = null
        try {
            val skey = SecretKeySpec(encryptionKey().toByteArray(), "AES")
            val cipher = Cipher.getInstance("AES/ECB/PKCS5Padding")
            cipher.init(Cipher.ENCRYPT_MODE, skey)
            crypted = cipher.doFinal(input.toByteArray(charset("UTF-8")))
        } catch (e: Exception) {
            println(e.toString())
        }
        return Base64.encodeToString(crypted, Base64.DEFAULT)
    }

    fun encryptionKey():String{
        return "mabzwENTsmb82605"
    }

}

