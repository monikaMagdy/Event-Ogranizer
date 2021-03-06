import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/Services/flutterfire.dart';
import 'package:mobile_project/screens/product_detail_screen.dart';
import 'package:mobile_project/screens/products_overview_screen.dart';
import 'package:mobile_project/widgets/user_product_item.dart';
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

  var _editedProduct = Event(
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
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = provider.Provider.of<Events>(context, listen: false)
            .findById(productId);
        _initValues = {
          'eventName': _editedProduct.eventName,
          'limitAttending': _editedProduct.limitAttending.toString(),
          'address': _editedProduct.address,
          'date': _editedProduct.date,
          'minimumCharge': _editedProduct.minimumCharge.toString(),
          'image': '',
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

  Future<void> _saveForm(String uID) async {
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
          .updateEvent(_editedProduct.id, _editedProduct, uID);
    } else {
      try {
        await Provider.of<Events>(context, listen: false)
            .addEvent(_editedProduct, uID);
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

    final productsData = provider.Provider.of<Events>(context, listen: false);
    padding:
    EdgeInsets.all(8);
    child:
    ListView.builder(
      itemCount: productsData.items.length,
      itemBuilder: (_, i) => Column(
        children: [
          UserProductItem(
            productsData.items[i].id,
            productsData.items[i].eventName,
            productsData.items[i].image,
          ),
          Divider(),
        ],
      ),
    );
    //Navigator.push(context,
    //    MaterialPageRoute(builder: (context) => ProductsOverviewScreen()));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: <Widget>[
          StreamBuilder(
              stream: AuthService().getUser(),
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
                        _editedProduct = Event(
                            eventName: value,
                            limitAttending: _editedProduct.limitAttending,
                            address: _editedProduct.address,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: _editedProduct.minimumCharge,
                            image: _editedProduct.image,
                            isFavorite: _editedProduct.isFavorite);
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
                        _editedProduct = Event(
                            eventName: _editedProduct.eventName,
                            limitAttending: int.parse(value),
                            address: _editedProduct.address,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: _editedProduct.minimumCharge,
                            image: _editedProduct.image,
                            isFavorite: _editedProduct.isFavorite);
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
                        _editedProduct = Event(
                            eventName: value,
                            limitAttending: _editedProduct.limitAttending,
                            address: value,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: _editedProduct.minimumCharge,
                            image: _editedProduct.image,
                            isFavorite: _editedProduct.isFavorite);
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
                              .then((date) {
                            setState(() {
                              onSaved:
                              (value) {
                                _editedProduct = Event(
                                    eventName: _editedProduct.eventName,
                                    limitAttending:
                                        _editedProduct.limitAttending,
                                    address: _editedProduct.address,
                                    date: value,
                                    dresscode: _editedProduct.dresscode,
                                    minimumCharge: _editedProduct.minimumCharge,
                                    image: _editedProduct.image,
                                    isFavorite: _editedProduct.isFavorite);
                              };
                            });
                          });
                        }),
                    DropdownButton(
                      // decoration: InputDecoration(),
                      focusColor: Colors.indigo[200],
                      value: eventDresscode.isNotEmpty ? eventDresscode : null,
                      onChanged: (var value) {
                        setState(() {
                          value = _dateTime;
                        });
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
                        _editedProduct = Event(
                            eventName: _editedProduct.eventName,
                            limitAttending: _editedProduct.limitAttending,
                            address: _editedProduct.address,
                            date: _editedProduct.date,
                            dresscode: _editedProduct.dresscode,
                            minimumCharge: int.parse(value),
                            image: _editedProduct.image,
                            isFavorite: _editedProduct.isFavorite);
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
                              _editedProduct = Event(
                                eventName: _editedProduct.eventName,
                                minimumCharge: _editedProduct.minimumCharge,
                                limitAttending: _editedProduct.limitAttending,
                                date: _editedProduct.date,
                                address: _editedProduct.address,
                                dresscode: _editedProduct.dresscode,
                                image: value,
                                isFavorite: _editedProduct.isFavorite,
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
