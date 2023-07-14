class WordAttributes {
  Map<String, dynamic> word;
  WordAttributes(this.word);

  bool isValid() {
    return word.isNotEmpty && getResults() != null;
  }

  String getWord() {
    return word['word'];
  }

  String getPronunciation() {
    //Validações excessivas são necessárias pois a API não é consistente
    if (word['pronunciation'] is String) {
      return word['pronunciation'];
    } else if (word['pronunciation'] is Map) {
      return word['pronunciation']['all']?.toString() ?? "No pronunciation";
    } else if (word['pronunciation'] is List) {
      if (word['pronunciation'].length > 0 && word['pronunciation'][0] is Map) {
        return word['pronunciation'][0]['all']?.toString() ??
            "No pronunciation";
      }
    }
    return "No pronunciation";
  }

  Map<String, dynamic>? getResults() {
    if (word['results'] == null) {
      return null;
    } else if (word['results'] is List) {
      return word['results'][0];
    } else if (word['results'] is Map) {
      return word['results'];
    }
    return null;
  }

  String? getResultsString(String key) {
    if (getResults() == null) {
      return null;
    } else if (getResults()![key] is String) {
      return getResults()![key]?.toString();
    } else if (getResults()![key] is List) {
      return getResults()![key][0]?.toString();
    } else {
      return null;
    }
  }

  List<String> getResultsList(String key) {
    if (getResults() == null) {
      return [];
    } else if (getResults()![key] is List) {
      return List<String>.from(getResults()![key] ?? []);
    } else {
      return [];
    }
  }
}
