import 'package:flutter/material.dart';

/// A widget to display network images with loading and error states.
///
/// This widget uses the standard `Image.network` constructor and does not
/// require any external packages like `cached_network_image`.
class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key? key,
    required this.url,
    this.fitModel = BoxFit.cover,
  }) : super(key: key);

  /// The URL of the image to be loaded.
  final String url;

  /// How the image should be inscribed into the box.
  final BoxFit fitModel;

  @override
  Widget build(BuildContext context) {
    // Using Flutter's built-in Image.network, which provides builders
    // for handling loading and error states.
    return Image.network(
      url,
      fit: fitModel,
      // A builder that's shown while the image is in the process of loading.
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        // If loading is complete, display the actual image.
        if (loadingProgress == null) {
          return child;
        }
        // While loading, display a circular progress indicator.
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null, // Indeterminate progress if total size is unknown.
            strokeWidth: 2.0,
            color: Colors.grey.shade400,
          ),
        );
      },
      // A builder that's shown if an error occurs during image loading.
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        // Display a standard error icon if the image fails to load.
        return Icon(
          Icons.error_outline,
          color: Colors.grey.shade300,
          size: 48,
        );
      },
      // Set custom HTTP headers if required.
      headers: const {'sec-fetch-mode': 'no-cors'},
    );
  }
}

/// A standardized widget to display when an error occurs or data is not found.
class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({Key? key, required this.message}) : super(key: key);

  /// The error message to be displayed.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display a visual indicator for the error.
            Icon(
              Icons.cloud_off_rounded,
              color: Colors.grey.shade500,
              size: 60,
            ),
            const SizedBox(height: 16),
            // Display the custom error message, with a default if none is provided.
            Text(
              message.isEmpty ? 'اطلاعاتی یافت نشد' : message, // Default message in Persian
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            )
          ],
        ),
      ),
    );
  }
}