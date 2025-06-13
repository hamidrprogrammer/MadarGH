// // MyWebSocketService.kt

// import android.app.Service
// import android.content.Intent
// import android.os.IBinder
// import android.util.Log
// import okhttp3.*
// import java.util.concurrent.TimeUnit

// class MyWebSocketService : Service() {

//     private lateinit var client: OkHttpClient
//     private lateinit var webSocket: WebSocket

//     override fun onBind(intent: Intent?): IBinder? {
//         return null
//     }

//     override fun onCreate() {
//         super.onCreate()
//         client = OkHttpClient.Builder()
//             .readTimeout(3, TimeUnit.SECONDS)
//             .build()
//         startWebSocketConnection()
//     }

//     private fun startWebSocketConnection() {
//         val request = Request.Builder()
//             .url("ws://your_server_ip:your_port/notifications/ws/singleNotification")
//             .build()

//         val listener = object : WebSocketListener() {
//             override fun onOpen(webSocket: WebSocket, response: Response) {
//                 Log.d(TAG, "WebSocket connection opened")
//             }

//             override fun onMessage(webSocket: WebSocket, text: String) {
//                 Log.d(TAG, "Received message: $text")
//                 // Handle received message
//             }

//             override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
//                 Log.d(TAG, "WebSocket connection closed: $reason")
//             }

//             override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
//                 Log.e(TAG, "WebSocket connection failure", t)
//             }
//         }

//         webSocket = client.newWebSocket(request, listener)
//     }

//     override fun onDestroy() {
//         super.onDestroy()
//         webSocket.cancel()
//         client.dispatcher.executorService.shutdown()
//     }

//     companion object {
//         private const val TAG = "MyWebSocketService"
//     }
// }
