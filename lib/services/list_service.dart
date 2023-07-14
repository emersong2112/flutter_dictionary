import 'package:flutter_dictionary/Services/api_service.dart';
import 'package:flutter_dictionary/Services/storage_service.dart';

///
/// Classe para gerenciar as listas de palavras,
/// podendo ser herdada para qualquer tipo de lista.
/// Exemplo: histórico, favoritos, lista personalizada, etc.
/// Para criar uma nova lista, basta herdar essa classe e sobrescrever os métodos necessários
///
class ListService {
  List<String> words = [];
  int currentPage = 1;

  ApiService api = ApiService();
  StorageService storage = StorageService();

  updateList({bool reset = false}) async {
    if (reset) {
      words = [];
      currentPage = 1;
    }

    words.addAll(
      await api.fetchStrings(
        page: currentPage,
        ignoreStorage: reset,
      ),
    );
    currentPage++;

    return words;
  }

  getList() async {
    if (words.isEmpty) {
      await updateList();
    }

    return words;
  }

  int getListCount() {
    return words.length;
  }

  String? getWord(int index) {
    if (index >= words.length) {
      return null;
    }
    return words[index];
  }

  addToCustomList(String word, {String modality = "custom"}) async {
    await getList(); //Garantindo que a lista está carregada

    // Caso já exista, sobe para o topo
    if (words.contains(word)) {
      words.remove(word);
    }

    words.add(word);
    await storage.setSavedData("custom-$modality-list", {"list": words});
  }

  getSavedCustomList({String modality = "custom"}) async {
    dynamic storageData = await storage.getSavedData("custom-$modality-list");
    if (storageData != null) {
      var mapData = Map<String, dynamic>.from(storageData);
      var list = mapData["list"] as List;
      words = list.map((item) => item.toString()).toList();
    }
  }
}
