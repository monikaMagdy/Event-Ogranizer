import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../provider/events.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String eventDresscode = 'classic';
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

  var _editedProduct = Event(
    id: null,
    eventCode: 0,
    eventName: '',
    minimumCharge: 0,
    limitAttending: 0,
    image: '',
    address: '',
    date: '',
    dresscode: '',
  );
  var _initValues = {
    'eventCode': '',
    'eventName': '',
    'minimumCharge': '',
    'limitAttending': '',
    'image': '',
    'address': '',
    'date': '',
    'dresscode': '',
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
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = provider.Provider.of<Events>(context, listen: false)
            .findById(productId);
        _initValues = {
          'event name': _editedProduct.eventName,
          'limit attending people': _editedProduct.limitAttending.toString(),
          'address': _editedProduct.address,
          'date': _editedProduct.date,
          'Minimum charge': _editedProduct.minimumCharge.toString(),
          'imageUrl': _editedProduct.image,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.image;
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

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Events>(context, listen: false)
          .updateEvent(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Events>(context, listen: false)
            .addEvent(_editedProduct);
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
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
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
                        _editedProduct = Event(
                            eventName: value,
                            limitAttending: _editedProduct.limitAttending,
                            address: _editedProduct.address,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: _editedProduct.minimumCharge,
                            image: _editedProduct.image,
                            eventCode: _editedProduct.eventCode,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
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
                        _editedProduct = Event(
                            eventName: value,
                            limitAttending: _editedProduct.limitAttending,
                            address: _editedProduct.address,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: _editedProduct.minimumCharge,
                            image: _editedProduct.image,
                            eventCode: _editedProduct.eventCode,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        hintText: 'Address',
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
                        _editedProduct = Event(
                            eventName: value,
                            limitAttending: _editedProduct.limitAttending,
                            address: _editedProduct.address,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: _editedProduct.minimumCharge,
                            image: _editedProduct.image,
                            eventCode: _editedProduct.eventCode,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    Text(
                      _dateTime == null
                          ? 'Select Your Event date'
                          : _dateTime.toString(),
                    ),
                    RaisedButton(
                        child: Text('Pick a Date'),
                        color: Colors.indigo[200],
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2022))
                              .then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        }),
                    DropdownButton(
                      // decoration: InputDecoration(),
                      focusColor: Colors.indigo[200],

                      value: eventDresscode.isNotEmpty ? eventDresscode : null,
                      onChanged: (var value) {
                        setState(() {
                          eventDresscode = value;
                        });
                      },

                      /* onSaved: (value) {
                        _editedProduct = Event(
                            eventName: value,
                            limitAttending: _editedProduct.limitAttending,
                            address: _editedProduct.address,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: _editedProduct.minimumCharge,
                            image: _editedProduct.image,
                            eventCode: _editedProduct.eventCode,
                            isFavorite: _editedProduct.isFavorite);
                      },*/
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
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
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
                      onSaved: (capacity) {
                        capacity = capacity;
                      },
                    ),
                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),*/
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            /* validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter an image URL.';
                                  }
                                  if (!value.startsWith('http') &&
                                      !value.startsWith('https')) {
                                    return 'Please enter a valid URL.';
                                  }
                                  if (!value.endsWith('.png') &&
                                      !value.endsWith('.jpg') &&
                                      !value.endsWith('.jpeg')) {
                                    return 'Please enter a valid image URL.';
                                  }
                                  return null;
                                },*/
                            onSaved: (value) {
                              _editedProduct = Event(
                                eventName: value,
                                minimumCharge: _editedProduct.minimumCharge,
                                limitAttending: _editedProduct.limitAttending,
                                date: _editedProduct.date,
                                address: _editedProduct.address,
                                dresscode: _editedProduct.dresscode,
                                image: _editedProduct.image,
                                eventCode: _editedProduct.eventCode,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // ],
              ),
            ),
      //),
    );
  }
}
