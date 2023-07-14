import 'package:flutter/material.dart';
import 'package:flutter_dictionary/components/Box/default_box.dart';
import 'package:flutter_dictionary/components/text/tag.dart';

class TagContainer extends StatelessWidget {
  final String title;
  final List<String> tags;

  const TagContainer({
    super.key,
    required this.title,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return tags.isEmpty
        ? Container()
        : DefaultBox(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) => TagText(tag)).toList(),
                ),
              ],
            ),
          );
  }
}
