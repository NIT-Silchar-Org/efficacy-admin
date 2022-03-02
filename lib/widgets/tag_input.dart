import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/appcolor.dart';

class TagInput extends StatefulWidget {
  const TagInput({Key? key}) : super(key: key);

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  var listTags = List<String>.empty(growable: true).obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSearch<String>(
          mode: Mode.MENU,
          dropdownSearchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(4),
            prefixIcon: Icon(Icons.person_outline_outlined,
                color: AppColorLight.outline),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColorLight.outline, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            ),
            labelText: 'Add Moderators',
            labelStyle: TextStyle(color: AppColorLight.outline),
          ),
          showSelectedItems: false,
          items: const ['Soumya', 'Apoorv', 'Biju'],
          onChanged: (e) {
            listTags.add(e!);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          (() => listTags.isEmpty
              ? const SizedBox(
                  height: 10,
                )
              : Wrap(
                  children: listTags
                      .map(
                        (element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(element),
                            deleteIcon: const Icon(Icons.clear),
                            onDeleted: () {
                              listTags.remove(element);
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
