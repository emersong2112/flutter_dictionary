import 'package:flutter/material.dart';
import 'package:flutter_dictionary/components/word/word_item.dart';
import 'package:flutter_dictionary/services/api_service.dart';
import 'package:flutter_dictionary/services/list_service.dart';

///
/// Página de lista de palavras, ela se adapta qualquer tipo de lista, pois uma ListService e passada como parâmetro
/// Podendo ser uma lista de palavras personalizada, histórico, favoritos, etc.
///
class WordListPage extends StatefulWidget {
  final ListService list;
  const WordListPage(this.list, {super.key});

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  ApiService api = ApiService();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  getList(bool update) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      List<String> aux =
          update ? await widget.list.updateList() : await widget.list.getList();

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    getList(false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 200) {
        getList(true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 7 / 5,
        ),
        itemCount: widget.list.getListCount() + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.list.getListCount()) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          } else {
            return WordItem(index,
                list: widget.list, onClosed: (dynamic _) => getList(true));
          }
        },
      ),
    );
  }
}
