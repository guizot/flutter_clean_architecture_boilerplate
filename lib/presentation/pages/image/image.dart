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

  List<Map<String, dynamic>> extLists = [
    {
      "title": "Grayscale",
      "method": (Image image) => image.toGrayscale(),
    },
    {
      "title": "Sepia",
      "method": (Image image) => image.toSepia(),
    },
    {
      "title": "Invert Color",
      "method": (Image image) => image.invertColors(),
    },
    {
      "title": "Brightness",
      "method": (Image image) => image.adjustBrightness(3.0),
    },
    {
      "title": "Blur Image",
      "method": (Image image) => image.blurImage(5.0, 5.0),
    },
    {
      "title": "Color Overlay",
      "method": (Image image) => image.colorOverlay(Colors.blue),
    },
    {
      "title": "Mirror Image",
      "method": (Image image) => image.mirrorImage(Axis.horizontal),
    },
    {
      "title": "Exposure",
      "method": (Image image) => image.adjustExposure(0.3),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: ListView.builder(
              itemCount: extLists.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      extLists[index]["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: extLists[index]["method"](Image.network(
                          'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2023/09/getty_creative.jpeg.jpg',
                          fit: BoxFit.cover, // Adjust the fit property
                        )),
                      ),
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