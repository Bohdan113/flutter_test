import 'package:intl/intl.dart';

class WebSite {
  final String url;
  final int? httpStatus;
  String lastUpdate = DateFormat('dd.MM.yyyy kk:mm').format(DateTime.now());
  String? iconUrl;
  bool sync;
  WebSite({required this.url, this.httpStatus, this.iconUrl, this.sync = false});


  @override
  String toString() {
    return url.toString();
  }
}