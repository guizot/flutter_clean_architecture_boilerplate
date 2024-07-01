import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/image_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/image_cubit.dart';

class ImageWrapperProvider extends StatelessWidget {
  const ImageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ImageCubit>(),
      child: const ImagePage(title: "Image Extension"),
    );
  }
}

class ImagePage extends StatefulWidget {
  const ImagePage({super.key, required this.title});
  final String title;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

  List<Map<String, dynamic>> extensionLists = [
    {
      "title": "Grayscale",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.toGrayscale();
        } else {
          return image;
        }
      },
      "applied": true
    },
    {
      "title": "Sepia",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.toSepia();
        } else {
          return image;
        }
      },
      "applied": true
    },
    {
      "title": "Inverted Color",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.invertColors();
        } else {
          return image;
        }
      },
      "applied": true
    },
    {
      "title": "Brightness",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.adjustBrightness(2.0);
        } else {
          return image;
        }
      },
      "applied": true
    },
    {
      "title": "Blur Image",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.blurImage(5.0, 5.0);
        } else {
          return image;
        }
      },
      "applied": true
    },
    {
      "title": "Color Overlay",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.colorOverlay(Colors.blue);
        } else {
          return image;
        }
      },
      "applied": true
    },
    {
      "title": "Mirror Image",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.mirrorImage(Axis.horizontal);
        } else {
          return image;
        }
      },
      "applied": true
    },
    {
      "title": "Exposure",
      "method": (Image image, bool isApplied) {
        if(isApplied) {
          return image.adjustExposure(0.3);
        } else {
          return image;
        }
      },
      "applied": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: ListView.builder(
              itemCount: extensionLists.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      extensionLists[index]["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: extensionLists[index]["method"](
                              Image.network(
                                'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2023/09/getty_creative.jpeg.jpg',
                                fit: BoxFit.cover, // Adjust the fit property
                              ),
                              extensionLists[index]["applied"]
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Switch(
                              value: extensionLists[index]["applied"],
                              onChanged: (value) {
                                setState(() {
                                  extensionLists[index]["applied"] = value;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Theme.of(context).colorScheme.inversePrimary
                            )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16)
                  ],
                );
              },
            )
          );
        }
    );
  }

}