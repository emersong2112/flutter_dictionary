import 'package:flutter/material.dart';

///
/// Box de visualização de uma palavra já com a pronuncioação
/// A pronúncia é opcional e pode ser nula
///
class WordView extends StatelessWidget {
  final String word;
  final String? pronunciation;
  const WordView({
    required this.word,
    this.pronunciation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFEDEDED),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            word,
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (pronunciation != null)
            Text(
              pronunciation!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
