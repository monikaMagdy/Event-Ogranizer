import 'package:flutter/material.dart';
import 'event.dart';
import 'your_event.dart';

class JoinEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Join Event';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        body: ListViewSearch(),
      ),
    );
  }
}

class ListViewSearch extends StatefulWidget {
  _ListViewSearchState createState() => _ListViewSearchState();
}

class _ListViewSearchState extends State<ListViewSearch> {
  TextEditingController _textController = TextEditingController();

  List<Event> _newData = [];

  _onChanged(String value) {
    setState(() {
      EventData eventData = new EventData();

      _newData = eventData.eventDB
          .where((eventData) =>
              (eventData.eventName.toLowerCase().contains(value.toLowerCase())))
          .toList();
    });
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
                                            ChoosenEvent.data(data))),
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
