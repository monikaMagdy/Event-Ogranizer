import 'package:flutter/material.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/widgets/user_event_item.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../provider/events.dart';

class EditEventScreen extends StatefulWidget {
  static const routeName = '/edit-event';

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String eventDresscode;
  DateTime _dateTime;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  final List<String> items = <String>[
    'Classic',
    'Halloween',
    'Fancy Dress',
    'semi-Fromal'
  ];

  var _editedEvent = Event(
    id: null,
    eventName: '',
    limitAttending: 0,
    address: '',
    date: '',
    dresscode: '',
    minimumCharge: 0,
    image: '',
  );
  var _initValues = {
    'id': '',
    'eventName': '',
    'limitAttending': '',
    'address': '',
    'date': '',
    'dresscode': '',
    'minimumCharge': '',
    'image': '',
  };
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    eventDresscode = items[0];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final eventId = ModalRoute.of(context).settings.arguments as String;
      if (eventId != null) {
        _editedEvent = provider.Provider.of<Events>(context, listen: false)
            .findById(eventId);
        _initValues = {
          'eventName': _editedEvent.eventName,
          'limitAttending': _editedEvent.limitAttending.toString(),
          'address': _editedEvent.address,
          'date': _editedEvent.date,
          'minimumCharge': _editedEvent.minimumCharge.toString(),
          'image': '',
        };
        _imageUrlController.text = _editedEvent.image;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm(String uID) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    debugPrint('edit' + _editedEvent.toString());
    if (_editedEvent.id != null) {
      await Provider.of<Events>(context, listen: false)
          .updateEvent(_editedEvent.id, _editedEvent, uID);
    } else {
      try {
        await Provider.of<Events>(context, listen: false)
            .addEvent(_editedEvent, uID);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });

    final eventsData = provider.Provider.of<Events>(context, listen: false);
    padding:
    EdgeInsets.all(8);
    child:
    ListView.builder(
      itemCount: eventsData.items.length,
      itemBuilder: (_, i) => Column(
        children: [
          UserEventItem(
            eventsData.items[i].id,
            eventsData.items[i].eventName,
            eventsData.items[i].image,
          ),
          Divider(),
        ],
      ),
    );
    //Navigator.push(context,
    //    MaterialPageRoute(builder: (context) => EventsOverviewScreen()));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
        actions: <Widget>[
          StreamBuilder(
              stream: UserAddNotifer().getUser(),
              // ignore: missing_return

              builder: (context, snapShot) {
                return IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () async {
                    await _saveForm(snapShot.data.uid);
                  },
                );
              }),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['eventName'],
                      decoration: InputDecoration(
                        labelText: 'eventName',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedEvent = Event(
                            id: _editedEvent.id,
                            eventName: value,
                            limitAttending: _editedEvent.limitAttending,
                            address: _editedEvent.address,
                            date: _editedEvent.date,
                            dresscode: _editedEvent.dresscode,
                            minimumCharge: _editedEvent.minimumCharge,
                            image: _editedEvent.image,
                            isFavorite: _editedEvent.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['limitAttending'],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      decoration: const InputDecoration(
                        labelText: 'limitAttending',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value.length < 2 || value.length > 4) {
                          return 'check capcity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedEvent = Event(
                            id: _editedEvent.id,
                            eventName: _editedEvent.eventName,
                            limitAttending: int.parse(value),
                            address: _editedEvent.address,
                            date: _editedEvent.date,
                            dresscode: _editedEvent.dresscode,
                            minimumCharge: _editedEvent.minimumCharge,
                            image: _editedEvent.image,
                            isFavorite: _editedEvent.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['address'],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else if (!RegExp('^^[a-zA-Z0-9]').hasMatch(value)) {
                          return 'Enter Valid Username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedEvent = Event(
                            id: _editedEvent.id,
                            eventName: _editedEvent.eventName,
                            limitAttending: _editedEvent.limitAttending,
                            address: value,
                            date: _editedEvent.date,
                            dresscode: _editedEvent.dresscode,
                            minimumCharge: _editedEvent.minimumCharge,
                            image: _editedEvent.image,
                            isFavorite: _editedEvent.isFavorite);
                      },
                    ),
                    Text(
                      _dateTime == null
                          ? 'Select Your Event date'
                          : _dateTime.toString(),
                    ),
                    RaisedButton(
                        child: Text('date'),
                        color: Colors.indigo[200],
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2022))
                              .then(
                            (value) {
                              setState(() {
                                _dateTime = value;
                              });
                              _editedEvent = Event(
                                  id: _editedEvent.id,
                                  eventName: _editedEvent.eventName,
                                  limitAttending: _editedEvent.limitAttending,
                                  address: _editedEvent.address,
                                  date: value.toString(),
                                  dresscode: _editedEvent.dresscode,
                                  minimumCharge: _editedEvent.minimumCharge,
                                  image: _editedEvent.image,
                                  isFavorite: _editedEvent.isFavorite);
                            },
                          );
                        }),
                    DropdownButton(
                      // decoration: InputDecoration(),
                      focusColor: Colors.indigo[200],
                      value: eventDresscode.isNotEmpty ? eventDresscode : null,
                      onChanged: (value) {
                        setState(() {
                          eventDresscode = value;
                        });
                        _editedEvent = Event(
                            id: _editedEvent.id,
                            eventName: _editedEvent.eventName,
                            limitAttending: _editedEvent.limitAttending,
                            address: _editedEvent.address,
                            date: _editedEvent.date,
                            dresscode: value,
                            minimumCharge: _editedEvent.minimumCharge,
                            image: _editedEvent.image,
                            isFavorite: _editedEvent.isFavorite);
                      },

                      items: items.map<DropdownMenuItem<String>>(
                        (String dressCode) {
                          return DropdownMenuItem<String>(
                            child: Text(dressCode),
                            value: dressCode,
                          );
                        },
                      ).toList(),
                    ),
                    TextFormField(
                      initialValue: _initValues['minimumCharge'],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        // FocusScope.of(context).requestFocus)FocusNode);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'minimumCharge',
                        counterText: '0 characters',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value.length < 2 || value.length > 4) {
                          return 'check capcity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedEvent = Event(
                            id: _editedEvent.id,
                            eventName: _editedEvent.eventName,
                            limitAttending: _editedEvent.limitAttending,
                            address: _editedEvent.address,
                            date: _editedEvent.date,
                            dresscode: _editedEvent.dresscode,
                            minimumCharge: int.parse(value),
                            image: _editedEvent.image,
                            isFavorite: _editedEvent.isFavorite);
                      },
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'image',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            //onFieldSubmitted: (_) {
                            //  _saveForm(SnapshotMetadata.);
                            //},
                            onSaved: (value) {
                              _editedEvent = Event(
                                id: _editedEvent.id,
                                eventName: _editedEvent.eventName,
                                minimumCharge: _editedEvent.minimumCharge,
                                limitAttending: _editedEvent.limitAttending,
                                date: _editedEvent.date,
                                address: _editedEvent.address,
                                dresscode: _editedEvent.dresscode,
                                image: value,
                                isFavorite: _editedEvent.isFavorite,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
