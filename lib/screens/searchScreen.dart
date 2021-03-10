import 'package:flutter/material.dart';
import 'package:mobile_project/models/event.dart';
import 'package:mobile_project/provider/events.dart';
import 'package:mobile_project/screens/Event_detail_screen.dart';
import 'package:mobile_project/screens/showSearchScreen.dart';
import 'package:provider/provider.dart' as provider;
import 'package:mobile_project/provider/events.dart';

class ListViewSearch extends StatefulWidget {
  _ListViewSearchState createState() => _ListViewSearchState();
}

class _ListViewSearchState extends State<ListViewSearch> {
  TextEditingController _textController = TextEditingController();

  List<Event> _newData = [];

  _onChanged(String value) {
    var _isLoading;

    setState(() {
      _isLoading = false;
    });
    final eventsData = provider.Provider.of<Events>(context, listen: false);
    _newData = eventsData.items
        .where((eventsData) =>
            (eventsData.eventName.toLowerCase().contains(value.toLowerCase())))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Filter/Search Example'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'enter text here',
              ),
              onChanged: _onChanged,
            ),
          ),
          SizedBox(height: 20.0),
          _newData != null && _newData.length != 0
              ? Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(10.0),
                    children: _newData.map((data) {
                      return ListTile(
                          title: Text(data.eventName),
                          onTap: () => [
                                _textController.text = data.eventName,
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EventDetailSearch.data(data))),
                              ]);
                    }).toList(),
                  ),
                )
              : SizedBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(_textController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
