import 'package:flutter_dictionary/services/list_service.dart';

///
/// Gerenciamento de Histórico, herdando de ListService
/// Para obter uma instância dessa classe, basta chamar WordListService(), a classe é um singleton
///
class WordListService extends ListService {
  static final WordListService _instance = WordListService._internal();

  WordListService._internal() : super();

  factory WordListService() {
    return _instance;
  }
}
