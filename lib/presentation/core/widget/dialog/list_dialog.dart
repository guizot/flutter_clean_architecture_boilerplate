import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/model/common_list_model.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_controller.dart';

class ListDialog extends StatefulWidget {
  final String title;
  final List<CommonListModel> lists;
  final Function(CommonListModel, int) onChange;
  final bool isBottom;

  const ListDialog({super.key,
    required this.title,
    required this.lists,
    required this.onChange,
    this.isBottom = false
  });

  @override
  State<ListDialog> createState() => _ListDialogState();
}

class _ListDialogState  extends State<ListDialog> {

  final FormController controller = FormController();

  @override
  Widget build(BuildContext context) {
    return !widget.isBottom ? Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.grey)
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: buildChild(context),
    ) : buildChild(context);
  }

  Widget buildChild(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container (
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5
                                  ),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20.0,
                                  color: Colors.grey,
                                )
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 215,
                        color: Theme.of(context).colorScheme.surface,
                        child: widget.lists.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.lists.length,
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: widget.lists.length - 1 == index ? 0.0 : 1.0,
                                      color: Colors.grey
                                    )
                                  ), // Add border color
                                ),
                                child: ListTile(
                                  title: Text("${widget.lists[index].title} ${widget.lists[index].id}"),
                                  subtitle: Text(widget.lists[index].subtitle),
                                  trailing: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            widget.onChange(widget.lists[index], index);
                                            widget.lists.remove(widget.lists[index]);
                                          });
                                        },
                                        child: Container (
                                            padding: const EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1.5
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.delete_outline_outlined,
                                              size: 20.0,
                                              color: Colors.grey,
                                            )
                                        ),
                                      )
                                  )
                                )
                            );
                          },
                        )
                            : const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.not_interested_outlined, size: 36.0),
                                  SizedBox(height: 8.0),
                                  Text("No Data"),
                                ],
                              )
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      )
    );
  }

}
