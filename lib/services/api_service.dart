import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dictionary/Services/storage_service.dart';
import 'package:flutter_dictionary/services/history_service.dart';
import 'package:flutter_dictionary/utils/word_attributes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

///
/// Gerenciamento de APIs, permitindo a busca de palavras e detalhes de uma palavra em específico
/// Todos os dados obtidos são salvos em cache para evitar requisições desnecessárias
///
/// Para obter uma instância dessa classe, basta chamar ApiService(), a classe é um singleton
///
///
class ApiService {
  static final ApiService _instance = ApiService._internal();
  ApiService._internal();
  factory ApiService() {
    return _instance;
  }

  final StorageService storage = StorageService();
  final Dio _dio = Dio();

  ///
  /// Busca uma lista de palavras, podendo ser filtrada por uma query e uma página
  /// A paginação já foi implementada em front.
  /// As querys funcionam perfeitamente, mas não foram implementadas em front.
  /// O ignoreStorage é usado para ignorar o cache e forçar uma nova requisição
  /// O cache é salvo apenas na primeira pagina, para evitar que a lista fique
  /// repetitiva, desatualizada e muito grande
  ///
  Future<List<String>> fetchStrings({
    String? query,
    int page = 1,
    ignoreStorage = false,
  }) async {
    final apiUrl = dotenv.env['LIST_API_URL'] ?? "";
    final token = dotenv.env['LIST_API_KEY'] ?? "";
    String url = "";
    if (query != null) {
      url = '$apiUrl?q=$query&page=$page';
    } else {
      url = '$apiUrl?page=$page';
    }
    if (page == 1 && !ignoreStorage) {
      dynamic storageData = await storage.getSavedData(apiUrl);
      if (storageData != null) {
        var mapData = Map<String, dynamic>.from(storageData);
        var list = mapData["list"] as List;
        return list.map((item) => item.toString()).toList();
      }
    }
    try {
      var response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 200) {
        if (page == 1) {
          await storage.setSavedData(apiUrl, {"list": response.data});
        }
        var list = response.data as List;
        return list.map((item) => item.toString()).toList();
      }
    } on DioException catch (e) {
      throw Exception('Falha ao carregar palavras: ${e.message}');
    }
    await storage.setSavedData(apiUrl, {"list": []});
    return [];
  }

  ///
  /// Busca os detalhes de uma palavra
  /// Os dados são salvos em cache para evitar requisições desnecessárias
  /// As palavras selecionadas são adicionadas ao histórico automaticamente
  ///
  Future<WordAttributes> fetchWordDetails(String word) async {
    final apiUrl = "https://wordsapiv1.p.rapidapi.com/words/$word";
    final apiKey = dotenv.env['WORDS_API_KEY'] ?? "";

    dynamic storageData = await storage.getSavedData(apiUrl);
    if (storageData != null) {
      return WordAttributes(Map<String, dynamic>.from(storageData));
    }
    try {
      var response = await Dio().get(
        apiUrl,
        options: Options(
          headers: {
            "X-RapidAPI-Key": apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        print(jsonEncode(response.data));
        await storage.setSavedData(apiUrl, response.data);
        await HistoryListService().addToHistoryList(word);
        return WordAttributes(Map<String, dynamic>.from(response.data));
      } else {
        throw Exception(
            'Falha ao carregar detalhes da palavra: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print("Palavra não encontrada");
        await storage.setSavedData(apiUrl, {});
        await HistoryListService().addToHistoryList(word);
        return WordAttributes({});
      }
      throw Exception('Falha ao carregar detalhes da palavra: ${e.message}');
    }
  }
}
