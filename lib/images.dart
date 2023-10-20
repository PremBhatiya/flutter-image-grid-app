import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef void LoadingFinishedCallback();

class ImageGrid extends StatelessWidget {
  final LoadingFinishedCallback onLoadingFinished;

  ImageGrid({required this.onLoadingFinished});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      child: GridView.builder(
        itemCount: 50,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // The number of grid items along cross axis
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/300/300?random=$index',
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Colors.greenAccent.shade700,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) {
                  if (index == 49) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      onLoadingFinished();
                    });
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}