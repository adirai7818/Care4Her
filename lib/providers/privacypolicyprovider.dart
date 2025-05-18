import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../const/consts.dart';

class PrivacyPolicyProvider with ChangeNotifier {
  PrivacyPolicyProvider() {
    fetchPrivacypolicyContent();
  }

  String? _privacypolicyContent;
  String? get privacypolicyContent => _privacypolicyContent;
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> refresh() async {
    _isFetching = true;
    await fetchPrivacypolicyContent();
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchPrivacypolicyContent() async {
    _isFetching = true;
    final url = Consts.PRIVACY_POLICY_URL;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _privacypolicyContent = response.body;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    _isFetching = false;
    notifyListeners();
  }
}
