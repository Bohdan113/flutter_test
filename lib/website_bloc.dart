import 'package:flutter/foundation.dart';
import 'package:flutter_test_app/website.dart';
import 'http_request.dart';

class WebSiteBloc with ChangeNotifier {
  final _list = <WebSite>[];

  List<WebSite> get list => _list;

  void addWebSite({required WebSite webSite}) {
    _list.add(webSite);
    if (kDebugMode) print('\nLIST: $_list\n');
    notifyListeners();
  }

  void removeWebSite({required WebSite webSite}) {
    _list.remove(webSite);
    notifyListeners();
  }

  void response({required String controller}) async {
    addWebSite(webSite: WebSite(url: controller));
    final website = await httpRequest(controller);
    for (var i = 0; i < list.length; i++) {
      if (list[i].url == controller) {
        list[i] = website;
      }
    }
    notifyListeners();
  }

  void updateWebSiteList() async {
    for (var i = 0; i < list.length; i++) {
      list[i] = WebSite(url: list[i].url);
    }
    notifyListeners();
    for (var i = 0; i < list.length; i++) {
      await httpRequest(list[i].url).then((website) => list[i] = website);
      notifyListeners();
    }
  }

}
