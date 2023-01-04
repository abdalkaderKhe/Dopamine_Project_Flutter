import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {

  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding:const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Switch(
                value: isImportant ?? false,
                onChanged: onChangedImportant,
              ),
              Expanded(
                child: Slider(
                  value: (number ?? 0).toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (number) => onChangedNumber(number.toInt()),
                ),
              )
            ],
          ),
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style:const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration:const InputDecoration(
      border: InputBorder.none,
      hintText: 'العنوان',
      hintStyle: TextStyle(color: Colors.grey,fontFamily: "Almarai",),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'لا يمكن أن يكون العنوان فارغًا' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: Colors.grey, fontSize: 18),
    decoration:const InputDecoration(
      border: InputBorder.none,
      hintText: 'اكتب شيئا........',
      hintStyle: TextStyle(color: Colors.grey , fontFamily: "Almarai",),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'لا يمكن أن يكون الوصف فارغًا'
        : null,
    onChanged: onChangedDescription,
  );
}
