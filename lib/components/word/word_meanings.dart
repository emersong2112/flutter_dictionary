import 'package:flutter/material.dart';
import 'package:flutter_dictionary/components/text/info.dart';
import 'package:flutter_dictionary/components/text/tag_container.dart';
import 'package:flutter_dictionary/utils/word_attributes.dart';

class WordMeanings extends StatelessWidget {
  final WordAttributes word;
  const WordMeanings(this.word, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Meanings",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Info(
            title: 'Definition',
            content: word.getResultsString("definition"),
          ),
          Info(
            title: 'Derivation',
            content: word.getResultsString("derivation"),
          ),
          Info(
            title: 'Example',
            content: word.getResultsString("examples"),
          ),
          TagContainer(
            title: 'Type',
            tags: word.getResultsList("typeOf"),
          ),
          TagContainer(
            title: "Synonyms",
            tags: word.getResultsList('synonyms'),
          )
        ],
      ),
    );
  }
}
