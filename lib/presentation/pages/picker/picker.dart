import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/list_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/string_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/handler/picker_handler.dart';
import 'package:flutter_clean_architecture/presentation/core/mixins/share_mixin.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
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

class _PickerPageState extends State<PickerPage> with ShareMixin, TickerProviderStateMixin {

  late VideoPlayerController videoPlayerController;
  late TabController tabController;
  String singleImagePath = "";
  String singleVideoPath = "";
  List<File> multiImageFile = [];
  String singleFilePath = "";
  List<File> multiFile = [];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void pickImage(ImageSource source) async {
    final pickedImage = await PickerHandler().pickImage(source);
    if(pickedImage?.path != null) {
      setState(() {
        singleImagePath =  pickedImage!.path;
      });
    }
  }

  void pickVideo(ImageSource source) async {
    final pickedVideo = await PickerHandler().pickVideo(source);
    if(pickedVideo?.path != null) {
      setState(() {
        singleVideoPath =  pickedVideo!.path;
        videoPlayerController = VideoPlayerController.file(File(singleVideoPath));
        videoPlayerController.addListener(() {
          setState(() { });
        });
        videoPlayerController.initialize();
      });
    }
  }

  void pickMultiImage() async {
    final pickedImages = await PickerHandler().multiImages();
    if(pickedImages != null) {
      setState(() {
        multiImageFile = pickedImages.map((item) {
          return File(item.path);
        }).toList();
      });
    }
  }

  void shareFile(String path) {
    XFile file = XFile(path);
    shareFiles([file], text: '', subject: '');
  }

  void pickFile(bool isMultiple) async {
    final pickedFile = await PickerHandler().pickFiles(isMultiple: isMultiple);
    if(pickedFile != null && pickedFile.isNotEmpty) {
      setState(() {
        if(isMultiple) {
          multiFile =  pickedFile;
        } else {
          singleFilePath =  pickedFile.first.path;
        }
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              bottom: TabBar(
                controller: tabController,
                tabs: const <Widget>[
                  Tab(
                    icon: Icon(Icons.image_rounded),
                    child: Text("Image"),
                  ),
                  Tab(
                    icon: Icon(Icons.video_collection),
                    child: Text("Video"),
                  ),
                  Tab(
                    icon: Icon(Icons.file_copy_rounded),
                    child: Text("File"),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: <Widget>[
                Center(
                  child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      clipBehavior: Clip.none,
                      children: [

                        // IMAGE PICKER (SINGLE)
                        const Text(
                          "Image Picker (Single)",
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
                                      child: (singleImagePath != "")
                                          ? Image.file(
                                        File(singleImagePath),
                                        fit: BoxFit.cover,
                                      )
                                          : Container(
                                          color: Theme.of(context).hintColor.toMaterialColor().shade50,
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.image_outlined,
                                                size: 36,
                                              ),
                                              SizedBox(height: 8.0),
                                              Text("pick single image from camera or gallery.")
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
                                                onPressed: () => shareFile(singleImagePath)
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

                        // IMAGE PICKER (MULTIPLE)
                        const Text(
                          "Image Picker (Multiple)",
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
                                          ? ListView(
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
                                                                        color: Theme.of(context).colorScheme.surface.toMaterialColor().shade800
                                                                    ),
                                                                    child: const Icon(
                                                                      Icons.close,
                                                                      size: 16,
                                                                    )
                                                                )
                                                            ),
                                                            const SizedBox(height: 4.0),
                                                            GestureDetector(
                                                                onTap: () => shareFile(item.path),
                                                                child: Container(
                                                                    height: 30,
                                                                    width: 30,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(24.0),
                                                                        border: Border.all(color: Colors.grey),
                                                                        color: Theme.of(context).colorScheme.surface.toMaterialColor().shade800
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
                                          : Container(
                                          color: Theme.of(context).hintColor.toMaterialColor().shade50,
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.image_sharp,
                                                size: 36,
                                              ),
                                              SizedBox(height: 8.0),
                                              Text("pick multiple image from gallery.")
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
                                          "Pick Multiple Image",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: const Icon(Icons.arrow_forward),
                                        onTap: () => pickMultiImage(),
                                      )
                                  ),
                                ],
                              )
                          ),
                        ),

                      ]
                  )
                ),
                Center(
                  child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      clipBehavior: Clip.none,
                      children: [

                        // VIDEO PICKER (SINGLE)
                        const Text(
                          "Video Picker (Single)",
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
                                      child: (singleVideoPath != "")
                                          ? Center(
                                        child: videoPlayerController.value.isInitialized
                                            ? Stack(
                                          children: [
                                            ClipRRect(
                                                child: SizedBox.expand(
                                                    child: FittedBox(
                                                        alignment: Alignment.center,
                                                        fit: BoxFit.cover,
                                                        child: SizedBox(
                                                          height: videoPlayerController.value.size.height,
                                                          width: videoPlayerController.value.size.width,
                                                          child: VideoPlayer(videoPlayerController),
                                                        )
                                                    )
                                                )
                                            ),
                                            Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                              padding: const EdgeInsets.all(10.0),
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(24.0),
                                                                  border: Border.all(color: Colors.grey),
                                                                  color: Theme.of(context).colorScheme.surface.toMaterialColor().shade800
                                                              ),
                                                              child: ClipRRect(
                                                                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                                                  child: VideoProgressIndicator(
                                                                    videoPlayerController,
                                                                    allowScrubbing: true,
                                                                    colors: VideoProgressColors(
                                                                      playedColor: Theme.of(context).hintColor.toMaterialColor().shade500,
                                                                    ),
                                                                    padding: EdgeInsets.zero,
                                                                  )
                                                              )
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8.0),
                                                        GestureDetector(
                                                            onTap: () => videoPlayerController.value.isPlaying
                                                                ? videoPlayerController.pause()
                                                                : videoPlayerController.play(),
                                                            child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(24.0),
                                                                    border: Border.all(color: Colors.grey),
                                                                    color: Theme.of(context).colorScheme.surface.toMaterialColor().shade800
                                                                ),
                                                                child: Icon(
                                                                  videoPlayerController.value.isPlaying
                                                                      ? Icons.pause
                                                                      : Icons.play_arrow,
                                                                  size: 18,
                                                                )
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                )
                                            )
                                          ],
                                        )
                                            : Container(),
                                      )
                                          : Container(
                                          color: Theme.of(context).hintColor.toMaterialColor().shade50,
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.video_collection_rounded,
                                                size: 36,
                                              ),
                                              SizedBox(height: 8.0),
                                              Text("pick single video from camera or gallery.")
                                            ],
                                          )
                                      )
                                  ),
                                  (singleVideoPath != "")
                                      ? Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        border: Border(top: BorderSide(color: Colors.grey)),
                                      ),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.only(left: 16, right: 8),
                                        title: Text(
                                          singleVideoPath,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Wrap(
                                          children: [
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.share,
                                                  size: 20,
                                                ),
                                                onPressed: () => shareFile(singleVideoPath)
                                            ),
                                            IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () => setState(() {
                                                  singleVideoPath = "";
                                                  videoPlayerController.dispose();
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
                                                          onTap: () => pickVideo(ImageSource.gallery),
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
                                                          onTap: () => pickVideo(ImageSource.camera),

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

                      ]
                  ),
                ),
                Center(
                  child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      clipBehavior: Clip.none,
                      children: [

                        // FILE PICKER (SINGLE)
                        const Text(
                          "File Picker (Single)",
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
                                  (singleFilePath != "")
                                      ? Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row (
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 80,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft: Radius.circular(8),
                                                  bottomRight: Radius.circular(8),
                                                ),
                                                border: Border.all(color: Colors.grey),
                                                color: Theme.of(context).hintColor.toMaterialColor().shade50,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  singleFilePath.getFileExtension().toUpperCase(),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              )
                                          ),
                                          const SizedBox(width: 16.0),
                                          Expanded(
                                              child: Text(
                                                  singleFilePath.getFileName(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  )
                                              )
                                          )
                                        ],
                                      )
                                  )
                                      : Container(
                                      height: 120,
                                      width: double.infinity,
                                      color: Theme.of(context).hintColor.toMaterialColor().shade50,
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.file_copy_outlined,
                                            size: 36,
                                          ),
                                          SizedBox(height: 8.0),
                                          Text("pick a single file from files.")
                                        ],
                                      )
                                  ),
                                  (singleFilePath != "")
                                      ? Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        border: Border(top: BorderSide(color: Colors.grey)),
                                      ),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.only(left: 16, right: 8),
                                        title: Text(
                                          singleFilePath,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Wrap(
                                          children: [
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.share,
                                                  size: 20,
                                                ),
                                                onPressed: () => shareFile(singleFilePath)
                                            ),
                                            IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () => setState(() {
                                                  singleFilePath = "";
                                                })
                                            )
                                          ],
                                        ),
                                      )
                                  )
                                      : Container(),
                                  Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        border: Border(top: BorderSide(color: Colors.grey)),
                                      ),
                                      child: ListTile(
                                        title: const Text(
                                          "Pick Single File",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: const Icon(Icons.arrow_forward),
                                        onTap: () => pickFile(false),
                                      )
                                  ),
                                ],
                              )
                          ),
                        ),

                        // DIVIDER
                        const SizedBox(height: 24.0),

                        // FILE PICKER (MULTIPLE)
                        const Text(
                          "File Picker (Multiple)",
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
                                      height: 120,
                                      width: double.infinity,
                                      child: (multiFile.isNotEmpty)
                                          ? ListView(
                                          padding: const EdgeInsets.all(16.0),
                                          scrollDirection: Axis.horizontal,
                                          children: multiFile.mapIndexed((index, item) {
                                            return Container(
                                                margin: const EdgeInsets.only(right: 16.0),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                        height: 80,
                                                        width: 65,
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(24),
                                                            topRight: Radius.circular(8),
                                                            bottomLeft: Radius.circular(8),
                                                            bottomRight: Radius.circular(8),
                                                          ),
                                                          border: Border.all(color: Colors.grey),
                                                          color: Theme.of(context).hintColor.toMaterialColor().shade50,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            item.path.getFileExtension().toUpperCase(),
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                    Positioned(
                                                        top: -8.0,
                                                        right: -8.0,
                                                        child: Column(
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () => setState(() {
                                                                  multiFile.remove(item);
                                                                }),
                                                                child: Container(
                                                                    height: 24,
                                                                    width: 24,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(24.0),
                                                                        border: Border.all(color: Colors.grey),
                                                                        color: Theme.of(context).colorScheme.surface.toMaterialColor().shade800
                                                                    ),
                                                                    child: const Icon(
                                                                      Icons.close,
                                                                      size: 14,
                                                                    )
                                                                )
                                                            ),
                                                            // const SizedBox(height: 4.0),
                                                            // GestureDetector(
                                                            //     onTap: () => shareFile(item.path),
                                                            //     child: Container(
                                                            //         height: 24,
                                                            //         width: 24,
                                                            //         decoration: BoxDecoration(
                                                            //             borderRadius: BorderRadius.circular(24.0),
                                                            //             border: Border.all(color: Colors.grey),
                                                            //             color: Theme.of(context).colorScheme.background.toMaterialColor().shade800
                                                            //         ),
                                                            //         child: const Icon(
                                                            //           Icons.share,
                                                            //           size: 12,
                                                            //         )
                                                            //     )
                                                            // ),
                                                          ],
                                                        )
                                                    ),
                                                  ],
                                                )
                                            );
                                          }).toList()
                                      )
                                          : Container(
                                          color: Theme.of(context).hintColor.toMaterialColor().shade50,
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.file_copy,
                                                size: 36,
                                              ),
                                              SizedBox(height: 8.0),
                                              Text("pick a multiple file from files.")
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
                                          "Pick Multiple File",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: const Icon(Icons.arrow_forward),
                                        onTap: () => pickFile(true),
                                      )
                                  ),
                                ],
                              )
                          ),
                        ),

                      ]
                  ),
                ),
              ],
            )
          );
        }
    );
  }

}