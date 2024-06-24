import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/model/common_list_model.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/widget/dialog/list_dialog.dart';
import 'package:flutter_clean_architecture/presentation/core/widget/dialog/submission_dialog.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/widget/dialog/confirmation_dialog.dart';
import '../../core/widget/common_list_item.dart';
import 'cubit/dialog_cubit.dart';

class DialogWrapperProvider extends StatelessWidget {
  const DialogWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DialogCubit>(),
      child: const DialogPage(title: "Dialog Designer"),
    );
  }
}

class DialogPage extends StatefulWidget {
  const DialogPage({super.key, required this.title});
  final String title;

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {

  List<CommonListModel> lists = [
    CommonListModel(
      title: "Confirmation Dialog",
      subtitle: "more like a confirmation alert to continue or cancel action",
      tap: (BuildContext context) {
        DialogHandler.showAlertDialog(
            context: context,
            child: ConfirmationDialog(
              title: "Delete Confirmation",
              subtitle: "Your decision to delete this item is significant as it cannot be undone. Once deleted, all associated data will be permanently erased from the system. To proceed with this irreversible action, please provide your confirmation by clicking 'Yes, Delete.' If you're uncertain, you may opt to 'Cancel' to retain the item.",
              positiveCallback: () {
                Navigator.of(context).pop();
              },
              positiveText: "Yes, Delete",
              negativeCallback: () {
                Navigator.of(context).pop();
              },
              negativeText: "No, Cancel",
            )
        );
      }
    ),
    CommonListModel(
        title: "Warning Dialog",
        subtitle: "to warn user's action is done or unavailable",
        tap: (BuildContext context) {
          DialogHandler.showAlertDialog(
              context: context,
              child: ConfirmationDialog(
                title: "Warning Alert",
                subtitle: "Deletion of this item is currently not possible because certain prerequisite actions must be completed first. Please resolve any associated tasks or dependencies, and ensure no ongoing processes rely on this item. For further guidance, refer to our help section or contact support.",
                negativeCallback: () {
                  Navigator.of(context).pop();
                },
                negativeText: "OK, I Understand",
              )
          );
        }
    ),
    CommonListModel(
        title: "Submission Dialog",
        subtitle: "text field and button dialog example",
        tap: (BuildContext context) {
          DialogHandler.showAlertDialog(
              context: context,
              child: SubmissionDialog(
                title: "Add Item",
                labelCallback: "Add",
                addCallback: (String value) {
                  log("VALUE: $value");
                }
              )
          );
        }
    ),
    CommonListModel(
        title: "List Dialog",
        subtitle: "example list on a dialog",
        tap: (BuildContext context) {
          DialogHandler.showAlertDialog(
              context: context,
              child: ListDialog(
                title: "Items",
                lists: [
                  CommonListModel(
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                    tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                  CommonListModel(
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                      tap: (BuildContext context) { }
                  ),
                ]
              )
          );
        }
    ),
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
            shrinkWrap: true,
            itemCount: lists.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), // Adjust border radius as needed
                    border: Border.all(color: Colors.grey), // Add border color
                  ),
                  child: CommonListItem(
                    title: lists[index].title,
                    subtitle: lists[index].subtitle,
                    onTap: lists[index].tap,
                  )
              );
            },
          )
        );
      }
    );
  }

}

