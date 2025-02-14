import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../const/consts.dart';

class TermsConditionsProvider with ChangeNotifier {
  TermsConditionsProvider() {
    fetchTermsConditionsContent();
  }

  String? _termsConditionsContent;
  String? get termsConditionsContent => _termsConditionsContent;
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> refresh() async {
    _isFetching = true;
    await fetchTermsConditionsContent();
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchTermsConditionsContent() async {
    _isFetching = true;
    final url = Consts.TERMS_CONDITIONS_URL;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _termsConditionsContent = response.body;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    _isFetching = false;
    notifyListeners();
  }
}
