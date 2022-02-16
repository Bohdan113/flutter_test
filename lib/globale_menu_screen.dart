import 'package:flutter/material.dart';
import 'package:flutter_test_app/website_bloc.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'list_item_widget.dart';

class GlobalMenuScreen extends StatefulWidget {
  const GlobalMenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GlobalMenuScreen> createState() => _GlobalMenuScreenState();
}

class _GlobalMenuScreenState extends State<GlobalMenuScreen> {
  bool catchErrorString = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<WebSiteBloc>(
      builder: (BuildContext context, provider, Widget? child) =>
          Scaffold(
            appBar: AppBar(
              title: const Text('Web-sites Availability Checker'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    splashRadius: MediaQuery
                        .of(context)
                        .size
                        .width / 20,
                    onPressed: () => provider.updateWebSiteList(),
                    icon: Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: provider.list.length,
              itemBuilder: (context, index) {
                final item = provider.list[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Dismissible(
                    key: ValueKey(item),

                    onDismissed: (direction) {
                      setState(() {
                        provider.removeWebSite(webSite: item);
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                          SnackBar(content: Text('$item deleted')));
                    },
                    background: Container(color: Colors.red),
                    secondaryBackground: Container(color: Colors.red),
                    child: ListItemWidget(website: provider.list[index]),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                catchErrorString = false;
                _showMyDialog(webSiteBloc: provider);
                },
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }

  void enteringHttpQuery({required TextEditingController controller,required WebSiteBloc webSiteBloc}) {
    bool isList = false;
    for (var i = 0; i < webSiteBloc.list.length; i++) {
      if (webSiteBloc.list[i].url == controller.text) {
        isList = true;
      }}
      String userInput = controller.text;
      bool isValid = isURL(userInput); // false
      if (isValid == true) {
        catchErrorString = false;
        isList?null:webSiteBloc.response(controller: controller.text);
        Navigator.of(context).pop();
        isList?ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${controller.text} have in list'))):ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${controller.text} added to list')));
        isList = false;
      } else {
        catchErrorString = true;
      }
    }

    Future<void> _showMyDialog({required WebSiteBloc webSiteBloc}) async {
      final controller = TextEditingController();
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add new Website'),
                catchErrorString
                    ? Text(
                  'Error http request',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ):SizedBox()
              ],
            ),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Website URL',
              ),
            ),
            actions: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Color(0xFFE3E0E0))),
                  onPressed: () {
                    enteringHttpQuery(controller: controller,webSiteBloc: webSiteBloc);
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }