import 'package:core/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:my_ios_app/data/serializer/home/CategoryDetailResponse.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MamakTitle.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/home/CategoryDetailViewModel.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class CategoryDetailUI extends StatelessWidget {
  const CategoryDetailUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => CategoryDetailViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<CategoryDetailResponse>(
          state: state,
          onSuccess: (data) {
            return MamakScaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: 32.radius,
                          bottomRight: 32.radius,
                        ),
                        color: Colors.pinkAccent.shade200,
                      ),
                      child: Column(
                        children: [
                          8.dpv,
                          MamakTitle(title: data.title ?? ''),
                          8.dpv,
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.memory(
                                base64Decode(bloc.images.headerImage ?? '')),
                          ),
                        ],
                      ),
                    ),
                    16.dpv,
                    Padding(
                      padding: 16.dpe,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            data.title ?? '',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'IRANSansXFaNum',),
                          ),
                          4.dpv,
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.subCategories?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  padding: 8.dpeh,
                                  margin: 8.dpe,
                                  decoration: BoxDecoration(
                                    borderRadius: 8.bRadius,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Text(data.subCategories
                                          ?.elementAt(index)
                                          .title ??
                                      ''),
                                );
                              },
                            ),
                          ),
                          16.dpv,
                          SizedBox(
                            height: 280,
                            child: MyVideoPlayer(
                                data:
                                    '${BaseUrls.storagePath}/Categories/${bloc.id}.mp4'),
                          ),
                          16.dpv,
                          Column(
                            children: List.generate(bloc.images.images.length,
                                (index) {
                              var imgData =
                                  base64Decode(bloc.images.images[index]);
                              return Column(
                                children: [
                                  Image.memory(
                                    imgData,
                                  ),
                                  10.dpv,
                                ],
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
