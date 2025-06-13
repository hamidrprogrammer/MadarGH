package com.codesfirst.grecaptcha

import android.app.Activity
import androidx.annotation.NonNull
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.safetynet.SafetyNet
import com.google.android.gms.common.GoogleApiAvailability
import com.google.android.recaptcha.Recaptcha
import com.google.android.recaptcha.RecaptchaAction
import com.google.android.recaptcha.RecaptchaClient
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch


/** GrecaptchaPlugin */
class GrecaptchaPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private var activity: Activity? = null
  private lateinit var recaptchaClient: RecaptchaClient

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  //Methog for get Activity
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    this.activity = null;
  }
  //end

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_recaptcha")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "init" -> {
        if (activity == null) {
          result.error(
            "my_recaptcha",
            "No activity found, this plugin works with Activity only.",
            null
          )
          return
        }
        val siteKey: String = call.argument("key") ?: ""
        initializeRecaptchaClient(siteKey)
      }
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "isSupported" -> {
        if (activity == null) {
          result.error(
            "my_recaptcha",
            "No activity found, this plugin works with Activity only.",
            null
          )
        } else {
          if(GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(activity!!) == ConnectionResult.SUCCESS) {
            result.success(true)
            return
          }
          result.success(false)
        }
      }
      "checkGooglePlayServicesAvailability" -> checkGooglePlayServicesAvailability(result)
      "verify" -> {
        if (activity == null) {
          result.error(
            "my_recaptcha",
            "No activity found, this plugin works with Activity only.",
            null
          )
          return
        }

        if(!::recaptchaClient.isInitialized){
          result.error(
            "my_recaptcha",
            "recaptchaClient not initialized with this action = ${call?.argument("action") ?: ""}",
            null
          )
          return
        }
        val action: String = call?.argument("action") ?: ""

        CoroutineScope(Dispatchers.IO).launch {
          val token = recaptchaClient.execute(recaptchaAction = RecaptchaAction.custom(customAction = action))
          result.success(token.getOrNull() ?: "")
        }



      }
      else -> {
        result.notImplemented()
      }
    }
  }



  private fun initializeRecaptchaClient(siteKey:String) {
    CoroutineScope(Dispatchers.IO).launch {
      println("yes it can call CoroutineScope")
      Recaptcha.getClient(application = activity!?.application, siteKey = siteKey)
        .onSuccess { client ->
          recaptchaClient = client
        }
        .onFailure { exception ->
          println("failed to initialize Recaptcha because ${exception.message}")

          // Handle communication errors ...
          // See "Handle communication errors" section
        }
    }


  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  private fun checkGooglePlayServicesAvailability(result: Result) {
    if (activity == null) {
      result.error(
        "my_recaptcha",
        "No activity found, this plugin works with Activity only.",
        null
      )
      return
    }

    when (GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(activity!!)) {
      ConnectionResult.SUCCESS -> result.success("success")
      ConnectionResult.SERVICE_MISSING -> result.success("serviceMissing")
      ConnectionResult.SERVICE_UPDATING -> result.success("serviceUpdating")
      ConnectionResult.SERVICE_VERSION_UPDATE_REQUIRED -> result.success("serviceVersionUpdateRequired")
      ConnectionResult.SERVICE_DISABLED -> result.success("serviceDisabled")
      ConnectionResult.SERVICE_INVALID -> result.success("serviceInvalid")
      else -> result.error("Error", "Unknown error code", null)
    }
  }
}
