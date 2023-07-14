import 'package:flutter/material.dart';

///
/// Widget que exibe uma mensagem de erro quando a palavra não é encontrada
///
class WordNotFound extends StatelessWidget {
  const WordNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Text(
            "Infelizmente não temos dados sobre essa palavra.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        // DefaultButton(
        //     onPressed: () => Navigator.pop(context),
        //     child: const Text("Voltar à lista"))
      ],
    );
  }
}
