import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  String nameString = "Pick Image";
  String fileString = "Pick File";

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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: ListTile(
                      title: Text(nameString),
                      trailing: const Icon(Icons.arrow_forward_outlined),
                      onTap: () async {
                        final pickedImage = await PickerHandler().pickImage();
                        if(pickedImage?.path != null) {
                          setState(() {
                            nameString =  pickedImage!.path;
                          });
                          XFile file = XFile(pickedImage!.path);
                          shareFiles([file], text: '', subject: '');
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
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