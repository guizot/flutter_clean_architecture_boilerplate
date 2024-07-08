import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/notes/cubit/notes_state.dart';
import 'package:flutter_clean_architecture/presentation/pages/notes/notes_item_dialog.dart';
import '../../../data/models/note.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/common_list_model.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/widget/github/item_github.dart';
import '../../core/widget/list_skeleton.dart';
import 'cubit/notes_cubit.dart';

class NotesListWrapperProvider extends StatelessWidget {
  const NotesListWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotesCubit>(),
      child: const NotesListPage(title: "Notes List"),
    );
  }
}

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key, required this.title});
  final String title;

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {

  List<CommonListModel> lists = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future getNotes() async{
    lists.clear();
    List<Note> notes = await BlocProvider.of<NotesCubit>(context).getNotes();
    for(Note item in notes) {
      setState(() {
        lists.add(
            CommonListModel(
              title: item.title.toString(),
              subtitle: item.description.toString(),
              tap: () {
                showDetailNote(isNew: false, note: item);
              }
            )
        );
      });
    }
  }

  Widget loadList(BuildContext context, NotesCubitState state) {
    if(state is NotesStateLoading) {
      return ListView(
        children: const [
          ListSkeleton()
        ],
      );
    }
    else if(state is NotesStateLoaded) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: lists.length,
        itemBuilder: (context, index) {
          return ItemGithub(
            title: lists[index].title,
            subtitle: lists[index].subtitle,
            onTap: lists[index].tap,
          );
        },
      );
    }
    return Container();
  }

  void showDetailNote({required bool isNew, Note? note}) {
    DialogHandler.showAlertDialog(
        context: context,
        child: NotesItemDialog(
            title: isNew ? "Add Note" : "Update Note",
            noteTitle: isNew ? null : note?.title,
            noteDesc: isNew ? null : note?.description,
            addCallback: (String title, String description) {
              debugPrint("title: $title");
              debugPrint("description: $description");
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      icon: const Icon(
                          Icons.add,
                          size: 28
                      ),
                      tooltip: 'List Favorite',
                      onPressed: () {
                        showDetailNote(isNew: true);
                      },
                    ),
                  )
                ],
              ),
              body: BlocBuilder<NotesCubit, NotesCubitState>(
                builder: (context, state) {
                  return loadList(context, state);
                },
              )
          );
        }
    );
  }

}