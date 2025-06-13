import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/apiRoute/BaseUrls.dart';
import 'package:my_ios_app/data/serializer/home/HomeResponse.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({Key? key, required this.items}) : super(key: key);
  final List<CarrouselImages> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          width: 90,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ImageLoader(
                  url: BaseUrls.storagePath +
                      (items[index].src?.replaceAll("\\", "/") ?? ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  items[index].title ?? '',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                       fontFamily: 'IRANSansXFaNum',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
