import 'package:flutter_dictionary/services/list_service.dart';

///
/// Gerenciamento de Histórico, herdando de ListService
/// Para obter uma instância dessa classe, basta chamar HistoryListService(), a classe é um singleton
///
class HistoryListService extends ListService {
  static final HistoryListService _instance = HistoryListService._internal();
  @override
  List<String> words = [];
  HistoryListService._internal();
  factory HistoryListService() {
    return _instance;
  }

  @override
  getList() async {
    print("tá pegando a lista do history");
    if (words.isEmpty) {
      await getSavedCustomList(modality: "history");
    }

    return words.reversed.toList();
  }

  // Para o histórico e favoritos, getlist e updateList são iguais
  @override
  updateList({bool reset = false}) async {
    return await getList();
  }

  addToHistoryList(String word) async {
    await addToCustomList(word, modality: "history");
  }

  @override
  String? getWord(int index) {
    if (index >= words.length) {
      return null;
    }
    //Trazer em ordem decrescente
    return words.reversed.toList()[index];
  }
}
