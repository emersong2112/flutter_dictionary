import 'package:flutter/material.dart';
import 'package:flutter_dictionary/components/Box/default_box.dart';

class Info extends StatelessWidget {
  final String title;
  final String? content;
  const Info({
    required this.title,
    this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return content == null
        ? Container()
        : DefaultBox(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                Text(
                  content ?? "No data",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
  }
}
