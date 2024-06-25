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
import '../../core/widget/dialog/picker_dialog.dart';
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

    /// ALERT DIALOG
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
                      id: "001",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "002",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "003",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "004",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "005",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "006",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "007",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "008",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "009",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                    CommonListModel(
                      id: "010",
                      title: "TEST",
                      subtitle: "SUBTITLE IS HERE",
                    ),
                  ],
                  onChange: (CommonListModel item, int index) {
                    // log(item.toJson().toString());
                  }
              )
          );
        }
    ),
    CommonListModel(
        title: "Picker Dialog",
        subtitle: "example of date picker in dialog",
        tap: (BuildContext context) {
          DialogHandler.showAlertDialog(
              context: context,
              child: PickerDialog(
                  title: "Date Picker",
                  date: DateTime.now(),
                  onChange: (String date) {
                    log(date);
                  }
              )
          );
        }
    ),

    /// BOTTOM SHEET DIALOG
    CommonListModel(
        title: "Confirmation Bottom Dialog",
        subtitle: "more like a confirmation alert to continue or cancel action",
        tap: (BuildContext context) {
          DialogHandler.showBottomSheet(
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
                isBottom: true,
              )
          );
        }
    ),
    CommonListModel(
        title: "Warning Bottom Dialog",
        subtitle: "to warn user's action is done or unavailable",
        tap: (BuildContext context) {
          DialogHandler.showBottomSheet(
              context: context,
              child: ConfirmationDialog(
                title: "Warning Alert",
                subtitle: "Deletion of this item is currently not possible because certain prerequisite actions must be completed first. Please resolve any associated tasks or dependencies, and ensure no ongoing processes rely on this item. For further guidance, refer to our help section or contact support.",
                negativeCallback: () {
                  Navigator.of(context).pop();
                },
                negativeText: "OK, I Understand",
                isBottom: true,
              )
          );
        }
    ),
    CommonListModel(
        title: "Submission Bottom Dialog",
        subtitle: "text field and button dialog example",
        tap: (BuildContext context) {
          DialogHandler.showBottomSheet(
              context: context,
              child: SubmissionDialog(
                title: "Add Item",
                labelCallback: "Add",
                addCallback: (String value) {
                  log("VALUE: $value");
                },
                isBottom: true,
              )
          );
        }
    ),
    CommonListModel(
        title: "List Bottom Dialog",
        subtitle: "example list on a dialog",
        tap: (BuildContext context) {
          DialogHandler.showBottomSheet(
              context: context,
              child: ListDialog(
                title: "Items",
                lists: [
                  CommonListModel(
                    id: "001",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "002",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "003",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "004",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "005",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "006",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "007",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "008",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "009",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                  CommonListModel(
                    id: "010",
                    title: "TEST",
                    subtitle: "SUBTITLE IS HERE",
                  ),
                ],
                onChange: (CommonListModel item, int index) {
                  // log(item.toJson().toString());
                },
                isBottom: true,
              )
          );
        }
    ),
    CommonListModel(
        title: "Picker Bottom Dialog",
        subtitle: "example of date picker in dialog",
        tap: (BuildContext context) {
          DialogHandler.showBottomSheet(
              context: context,
              child: PickerDialog(
                title: "Date Picker",
                date: DateTime.now(),
                onChange: (String date) {
                  log(date);
                },
                isBottom: true,
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

