import 'package:flutter/material.dart';
import 'package:flutter_test_app/website.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    Key? key,
    required this.website,
  }) : super(key: key);

  final WebSite website;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: !website.sync
          ? CircularProgressIndicator()
          : website.iconUrl != null ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 13,
              child: Image.network(website.iconUrl!)) : null,
      tileColor:
          website.httpStatus == 200 ? Color(0xFFA1F846) : Color(0xFFEF9A30),
      title: Text(
        website.url,
        textAlign: TextAlign.start,
      ),
      subtitle: Row(
        children: [
          website.httpStatus == null
              ? Text('HTTP Code: XXX')
              : Text('HTTP Code: ${website.httpStatus}'),
          const Spacer(),
          Text('Last checked: ${website.lastUpdate}'),
        ],
      ),
    );
  }
}
