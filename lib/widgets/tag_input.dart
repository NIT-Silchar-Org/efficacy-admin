import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/appcolor.dart';

class TagInput extends StatefulWidget {
  final ValueChanged<List<String>> onValueChanged;
  const TagInput({Key? key, required this.onValueChanged}) : super(key: key);

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
          maxHeight: 200,
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColorLight.error, width: 2.0),
            ),
            labelText: 'Add Moderators',
            labelStyle: TextStyle(color: AppColorLight.outline),
          ),
          showSelectedItems: true,
          items: const ['Soumya', 'Apoorv', 'Biju'],
          validator: (val) {
            if (listTags.isEmpty) {
              return 'Required';
            } else {
              return null;
            }
          },
          onChanged: (e) {
            if (listTags.contains(e)) {
            } else {
              listTags.add(e!);
            }
          },
          onSaved: (e) {
            widget.onValueChanged(listTags);
          },
        ),
        const SizedBox(
          height: 5,
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
                            label: Text(
                              element,
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: AppColorLight.outline,
                                        fontSize: 14),
                              ),
                            ),
                            deleteIcon: const Icon(
                              Icons.clear,
                              size: 15,
                            ),
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


