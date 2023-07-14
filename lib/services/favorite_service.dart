import 'package:flutter_dictionary/services/list_service.dart';

///
/// Gerenciamento de Favoritos, herdando de ListService
///
/// /// Para obter uma instância dessa classe, basta chamar FavoriteListService(), a classe é um singleton
///
class FavoriteListService extends ListService {
  static final FavoriteListService _instance = FavoriteListService._internal();

  FavoriteListService._internal();
  factory FavoriteListService() {
    return _instance;
  }

  @override
  getList() async {
    if (words.isEmpty) {
      await getSavedCustomList(modality: "favorite");
    }

    return words.reversed.toList();
  }

  // Para o histórico e favoritos, getlist e updateList são iguais
  @override
  updateList({bool reset = false}) async {
    return await getList();
  }

  @override
  String? getWord(int index) {
    if (index >= words.length) {
      return null;
    }
    //Trazer em ordem decrescente
    return words.reversed.toList()[index];
  }

  bool isFavorite(String word) {
    return words.contains(word);
  }

  toggleFavorite(String word) async {
    if (words.contains(word)) {
      words.remove(word);
    } else {
      words.add(word);
    }
    await storage.setSavedData("custom-favorite-list", {"list": words});
    await getSavedCustomList(modality: "favorite");
  }
}
