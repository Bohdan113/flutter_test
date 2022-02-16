import 'package:flutter/foundation.dart';
import 'package:flutter_test_app/website.dart';
import 'package:http/http.dart' as http;
import 'package:favicon/favicon.dart';


Future<WebSite> httpRequest(String url) async {

  final urlPars = Uri.parse(url);

  final iconUrl = await Favicon.getBest(url);
  if (kDebugMode) print('ICONS $iconUrl\n\n');
  final urlIcon = iconUrl?.url;
  if (kDebugMode) print('ICONS $urlIcon\n\n');
  final httpResponse = await http.get(urlPars);
  final httpStatus = httpResponse.statusCode;
  if (kDebugMode) print('\nSTATUS CODE $httpStatus\n');

  return WebSite(url: url, httpStatus: httpStatus,
      iconUrl: urlIcon,sync: true);
}


