import 'package:flutter/material.dart';
import 'package:flutter_dictionary/Services/api_service.dart';
import 'package:flutter_dictionary/components/buttons/default_button.dart';
import 'package:flutter_dictionary/components/word/word_meanings.dart';
import 'package:flutter_dictionary/components/word/word_not_found.dart';
import 'package:flutter_dictionary/components/word/word_view.dart';
import 'package:flutter_dictionary/services/favorite_service.dart';
import 'package:flutter_dictionary/services/list_service.dart';
import 'package:flutter_dictionary/utils/word_attributes.dart';

///
/// Página de detalhes de uma palavra
///
class WordDetails extends StatefulWidget {
  final int wordIndex;
  final ListService list;
  const WordDetails(this.wordIndex, {required this.list, super.key});

  @override
  State<WordDetails> createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {
  // Example: {word: guzzler, results: [{definition: a drinker who swallows large amounts greedily, partOfSpeech: noun, synonyms: [gulper], typeOf: [drinker]}, {definition: someone who drinks heavily (especially alcoholic beverages), partOfSpeech: noun, typeOf: [drinker, imbiber, juicer, toper], examples: [he's a beer guzzler every night]}], syllables: {count: 2, list: [guz, zler]}, pronunciation: gʌzlɝr, frequency: 2.27};
  late WordAttributes wordDetails;
  int actualIndex = 0;
  bool isLoading = true;
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    actualIndex = widget.wordIndex;
    getIsFavorite();
  }

  getWordDetails() async {
    var aux = await ApiService()
        .fetchWordDetails(widget.list.getWord(actualIndex) ?? '');
    if (mounted) {
      setState(() {
        wordDetails = aux;
        isLoading = false;
      });
    }
    return true;
  }

  getIsFavorite() async {
    await FavoriteListService().getList();
    var word = widget.list.getWord(actualIndex) ?? "";
    if (mounted) {
      setState(() {
        isFavorite = FavoriteListService().isFavorite(word);
      });
    }
  }

  toggleFavoriteButton() {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (!isFavorite && widget.list is FavoriteListService) {
      Navigator.pop(context);
    }
    FavoriteListService()
        .toggleFavorite(widget.list.getWord(actualIndex) ?? '');
    getIsFavorite();
  }

  updateWord(int increment) async {
    int aux = actualIndex + increment;
    if (aux < 0) {
      aux = widget.list.getListCount() - 1;
    } else if (aux >= widget.list.getListCount()) {
      aux = 0;
    }
    getIsFavorite();

    setState(() {
      actualIndex = aux;
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Details'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getWordDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData && !isLoading) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: WordView(
                          word: widget.list.getWord(actualIndex) ?? '',
                          pronunciation: wordDetails.isValid()
                              ? wordDetails.getPronunciation()
                              : null,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () => toggleFavoriteButton(),
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  wordDetails.isValid()
                      ? WordMeanings(wordDetails)
                      : const WordNotFound(),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DefaultButton(
            onPressed: () {
              updateWord(-1);
            },
            child: const Icon(Icons.arrow_back),
          ),
          DefaultButton(
            onPressed: () {
              updateWord(1);
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
