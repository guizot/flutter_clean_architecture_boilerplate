import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/notes/notes_item_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../data/models/note.dart';
import '../../../data/models/note_response.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/common_list_model.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/widget/github/item_github.dart';
import '../../core/widget/list_skeleton.dart';
import 'cubit/graphql_notes_cubit.dart';
import 'cubit/graphql_notes_state.dart';

class GraphQLNotesListWrapperProvider extends StatelessWidget {
  const GraphQLNotesListWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GraphQLNotesCubit>(),
      child: const GraphQLNotesListPage(title: "GraphQL Notes List"),
    );
  }
}

class GraphQLNotesListPage extends StatefulWidget {
  const GraphQLNotesListPage({super.key, required this.title});
  final String title;

  @override
  State<GraphQLNotesListPage> createState() => _GraphQLNotesListPageState();
}

class _GraphQLNotesListPageState extends State<GraphQLNotesListPage> {

  List<CommonListModel> lists = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future getNotes() async {
    lists.clear();
    List<NoteModel> notes = await BlocProvider.of<GraphQLNotesCubit>(context).getGraphQLNotes();
    for(NoteModel item in notes) {
      setState(() {
        lists.add(
            CommonListModel(
              id: item.id.toString(),
              title: item.attributes.title.toString(),
              subtitle: item.attributes.description.toString(),
              tap: () => showDetailNote(isNew: false, note: item)
            )
        );
      });
    }
  }

  Widget loadList(BuildContext context, GraphQLNotesCubitState state) {
    if(state is GraphQLNotesStateLoading) {
      return ListView(
        children: const [
          ListSkeleton()
        ],
      );
    }
    else if(state is GraphQLNotesStateEmpty) {
      return const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.not_interested_outlined, size: 36.0),
            SizedBox(height: 8.0),
            Text("No Data"),
          ],
        )
      );
    }
    else if(state is GraphQLNotesStateLoaded) {
      return RefreshIndicator(
          onRefresh: () async {
            getNotes();
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: lists.length,
            itemBuilder: (context, index) {
              return Slidable(
                  key: ValueKey(index),
                  closeOnScroll: true,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await BlocProvider.of<GraphQLNotesCubit>(context).deleteNote(lists[index].id);
                          getNotes();
                        },
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ItemGithub(
                    title: lists[index].title,
                    subtitle: lists[index].subtitle,
                    onTap: lists[index].tap,
                  )
              );
            },
          )
      );
    }
    return Container();
  }

  void showDetailNote({required bool isNew, NoteModel? note}) {
    DialogHandler.showAlertDialog(
        context: context,
        child: NotesItemDialog(
            title: isNew ? "Add Note" : "Update Note",
            noteTitle: isNew ? null : note?.attributes.title,
            noteDesc: isNew ? null : note?.attributes.description,
            addCallback: (String title, String description) async {
              if(isNew) {
                await BlocProvider.of<GraphQLNotesCubit>(context).createNote(
                  Note(
                      id: "",
                      title: title,
                      description: description
                  )
                );
              } else {
                await BlocProvider.of<GraphQLNotesCubit>(context).updateNote(
                    Note(
                        id: note?.id,
                        title: title,
                        description: description
                    )
                );
              }
              getNotes();
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
                  IconButton(
                    icon: const Icon(
                        Icons.refresh,
                        size: 28
                    ),
                    tooltip: 'Refresh Token',
                    onPressed: () async {
                      await BlocProvider.of<GraphQLNotesCubit>(context).refreshToken();
                    },
                  ),
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
                  ),
                ],
              ),
              body: BlocBuilder<GraphQLNotesCubit, GraphQLNotesCubitState>(
                builder: (context, state) {
                  return loadList(context, state);
                },
              )
          );
        }
    );
  }

}