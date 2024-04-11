import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/list_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/handler/picker_handler.dart';
import 'package:flutter_clean_architecture/presentation/core/mixins/share_mixin.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/picker_cubit.dart';

class PickerWrapperProvider extends StatelessWidget {
  const PickerWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PickerCubit>(),
      child: const PickerPage(title: "Picker File"),
    );
  }
}

class PickerPage extends StatefulWidget {
  const PickerPage({super.key, required this.title});
  final String title;

  @override
  State<PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> with ShareMixin {

  String singleImagePath = "";
  List<File> multiImageFile = [];
  String fileString = "Pick File";

  void pickImage(ImageSource source) async {
    final pickedImage = await PickerHandler().pickImage(source);
    if(pickedImage?.path != null) {
      setState(() {
        singleImagePath =  pickedImage!.path;
      });
    }
  }

  void sharePickImage(String path) {
    XFile file = XFile(path);
    shareFiles([file], text: '', subject: '');
  }

  void multiImage() async {
    final pickedImages = await PickerHandler().multiImages();
    if(pickedImages != null) {
      setState(() {
        multiImageFile = pickedImages.map((item) {
          return File(item.path);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              clipBehavior: Clip.none,
              children: [

                // SINGLE IMAGE PICKER
                const Text(
                  "Single Image Picker",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: (singleImagePath != "")
                              ? Image.file(
                                File(singleImagePath),
                                fit: BoxFit.cover,
                              )
                              : Container(
                                  color: Theme.of(context).colorScheme.inversePrimary.toMaterialColor().shade100,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_rounded,
                                        size: 48,
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        "pick single image\nfrom camera or gallery.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      )
                                    ],
                                  )
                              )
                        ),
                        (singleImagePath != "")
                          ? Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.grey)),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(left: 16, right: 8),
                                title: Text(
                                  singleImagePath,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.share,
                                        size: 20,
                                      ),
                                      onPressed: () => sharePickImage(singleImagePath)
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => setState(() {
                                        singleImagePath = "";
                                      })
                                    )
                                  ],
                                ),
                              )
                          ) : Container(),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey)),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Center(
                                        child: IntrinsicWidth(
                                          child: ListTile(
                                            title: const Text(
                                              "Gallery",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            leading: const Icon(Icons.image_sharp),
                                            onTap: () => pickImage(ImageSource.gallery),
                                          ),
                                        )
                                    )
                                ),
                                const VerticalDivider(
                                    thickness: 1,
                                    width: 20,
                                    color: Colors.grey
                                ),
                                Flexible(
                                    child: Center(
                                        child: IntrinsicWidth(
                                          child: ListTile(
                                            title: const Text(
                                              "Camera",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            leading: const Icon(Icons.camera_alt_rounded),
                                            onTap: () => pickImage(ImageSource.camera),

                                          ),
                                        )
                                    )
                                ),
                              ],
                            )
                          )
                        ),
                      ],
                    )
                  ),
                ),

                // DIVIDER
                const SizedBox(height: 24.0),

                // MULTI IMAGE PICKER
                const Text(
                  "Multi Image Picker",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: (multiImageFile.isNotEmpty)
                                  ? Container(
                                    color: Theme.of(context).colorScheme.inversePrimary.toMaterialColor().shade100,
                                    child: ListView(
                                      padding: const EdgeInsets.all(16.0),
                                      scrollDirection: Axis.horizontal,
                                      children: multiImageFile.mapIndexed((index, item) {
                                        return Container(
                                          margin: EdgeInsets.only(right: multiImageFile.length - 1 == index ? 0.0 : 16.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  child:  Image.file(
                                                    item,
                                                    width: 148,
                                                    height: 148,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                              Positioned(
                                                  top: 8,
                                                  right: 4,
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () => setState(() {
                                                            multiImageFile.remove(item);
                                                          }),
                                                          child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(24.0),
                                                                  border: Border.all(color: Colors.grey),
                                                                  color: Theme.of(context).colorScheme.background.toMaterialColor().shade800
                                                              ),
                                                              child: const Icon(
                                                                Icons.close,
                                                                size: 16,
                                                              )
                                                          )
                                                      ),
                                                      const SizedBox(height: 4.0),
                                                      GestureDetector(
                                                          onTap: () => sharePickImage(item.path),
                                                          child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(24.0),
                                                                  border: Border.all(color: Colors.grey),
                                                                  color: Theme.of(context).colorScheme.background.toMaterialColor().shade800
                                                              ),
                                                              child: const Icon(
                                                                Icons.share,
                                                                size: 14,
                                                              )
                                                          )
                                                      )
                                                    ],
                                                  )
                                              ),
                                            ],
                                          )
                                        );
                                      }).toList()
                                    )
                                  )
                                  : Container(
                                    color: Theme.of(context).colorScheme.inversePrimary.toMaterialColor().shade100,
                                    child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_rounded,
                                        size: 36,
                                      ),
                                      SizedBox(height: 8.0),
                                      Text("pick multi image from gallery.")
                                    ],
                                  )
                                  )
                          ),
                          Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.grey)),
                              ),
                              child: ListTile(
                                title: const Text(
                                  "Pick Multi Image",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () => multiImage(),
                              )
                          ),
                        ],
                      )
                  ),
                ),

                // DIVIDER
                const SizedBox(height: 24.0),

                // FILE PICKER
                const Text(
                  "File Picker",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: ListTile(
                      title: Text(fileString),
                      trailing: const Icon(Icons.arrow_forward_outlined),
                      onTap: () async {
                        final pickedFiles = await PickerHandler().pickFiles();
                        if(pickedFiles != null) {
                          setState(() {
                            fileString =  pickedFiles.first.path;
                          });
                          XFile file = XFile(pickedFiles.first.path);
                          shareFiles([file], text: '', subject: '');
                        }
                      },
                    ),
                  ),
                )

              ]
            )
          );
        }
    );
  }

}