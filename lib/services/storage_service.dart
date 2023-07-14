import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///
/// Gerenciamento de Cache e armazenamento
///
/// A classe possui métodos para salvar e resgatar dados do cache com a conversão de JSON
/// e um sistema keys que mantém a organização dos dados.
///
/// Para obter uma instância dessa classe, basta chamar HistoryListService(), a classe é um singleton
///
class StorageService {
  static final StorageService _instance = StorageService._internal();
  StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  getSavedData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('dictionary-data-$key');
    return data != null
        ? jsonDecode(prefs.getString('dictionary-data-$key') ?? "{}")
        : null;
  }

  setSavedData(String key, Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dictionary-data-$key', jsonEncode(value));
  }

  removeSavedData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('dictionary-data-$key');
  }
}
