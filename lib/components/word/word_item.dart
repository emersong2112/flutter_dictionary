import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/Pages/word_details.dart';
import 'package:flutter_dictionary/services/list_service.dart';

class WordItem extends StatelessWidget {
  final int index;
  final ListService list;
  final onClosed;
  const WordItem(this.index, {required this.list, this.onClosed, super.key});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      closedColor: const Color(0xFFF5F5F5),
      closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      openBuilder: (BuildContext context, VoidCallback _) {
        return WordDetails(index, list: list);
      },
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              list.getWord(index) ?? "----",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
      onClosed: onClosed, //Erro foi aqui
    );
  }
}
