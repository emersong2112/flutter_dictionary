import 'package:flutter/material.dart';
import 'package:flutter_dictionary/pages/word_list.dart';
import 'package:flutter_dictionary/services/favorite_service.dart';
import 'package:flutter_dictionary/services/history_service.dart';
import 'package:flutter_dictionary/services/list_service.dart';
import 'package:flutter_dictionary/services/word_list_service.dart';

///
/// Página raiz do aplicativo, contém a barra de navegação e o appbar
///
class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  WordListService wordList = WordListService();
  HistoryListService historyList = HistoryListService();
  FavoriteListService favoriteList = FavoriteListService();

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    wordList.updateList(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      {
        "widget": WordListPage(wordList),
        "title": "Word List",
        "icon": Icons.list,
        "list": wordList
      },
      {
        "widget": WordListPage(historyList),
        "title": "History",
        "icon": Icons.history_rounded,
        "list": historyList
      },
      {
        "widget": WordListPage(favoriteList),
        "title": "Favorites",
        "icon": Icons.favorite_outline_rounded,
        "list": favoriteList
      },
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          final list = pages[index]["list"] as ListService;
          list.updateList();
          if (mounted) {
            setState(() {
              currentPageIndex = index;
            });
          }
        },
        selectedIndex: currentPageIndex,
        destinations: pages
            .map(
              (page) => NavigationDestination(
                icon: Icon(page["icon"] as IconData),
                label: page["title"] as String,
              ),
            )
            .toList(),
      ),
      body: SafeArea(
        child: pages[currentPageIndex]["widget"] as Widget,
      ),
      appBar: AppBar(
        title: Text(pages[currentPageIndex]["title"] as String),
        centerTitle: true,
      ),
    );
  }
}
