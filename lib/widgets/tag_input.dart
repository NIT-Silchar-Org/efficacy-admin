import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class TagInput extends StatefulWidget {
  const TagInput({Key? key}) : super(key: key);

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  var suggestTag = ["Apoorv", "Biju"];
  final controller = Get.put(TagStateController());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: textController,
              onEditingComplete: () {
                controller.listTags.add(textController.text);
                textController.clear();
              },
              autofocus: false,
              style: DefaultTextStyle.of(context).style,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tags",
              ),
            ),
            itemBuilder: (BuildContext context, String itemData) {
              return ListTile(
                leading: const Icon(Icons.tag),
                title: Text(itemData),
              );
            },
            onSuggestionSelected: (String? suggestion) =>
                controller.listTags.add(suggestion!),
            suggestionsCallback: (String pattern) {
              return suggestTag.where((element) =>
                  element.toLowerCase().contains(pattern.toLowerCase()));
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          (() => controller.listTags.isEmpty
              ? const Center(
                  child: Text("No tag selected"),
                )
              : Wrap(
                  children: controller.listTags
                      .map(
                        (element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(element),
                            deleteIcon: const Icon(Icons.clear),
                            onDeleted: () {
                              controller.listTags.remove(element);
                            },
                          ),
                        ),
                      )
                      .toList(),
                )),
        ),
      ],
    );
  }
}

class TagStateController extends GetxController {
  var listTags = List<String>.empty(growable: true).obs;
}
