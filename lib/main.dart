import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _genresController = TextEditingController();
  Color cardColor = Colors.white;
  bool _isLoading = false;
  List<String> _genres = [];
  bool _isPersonSelected = false;
  bool _isVirtualSelected = false;

  List<String> _selectedChips = [];

  Future<void> _getGenres() async {
    final response = await http
        .get(Uri.parse('https://apimocha.com/flutterassignment/getGenres'));
    final responseData = json.decode(response.body);

    final genres = responseData['data']['genres'] as List<dynamic>;

    setState(() {
      _genres = genres.map((genre) => genre['name'].toString()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getGenres();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _genresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "sign up",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  )))
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Let’s create your Account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white),
                  // hintText: 'First Name',
                  // hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your username',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your Email',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email.';
                  }

                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    "Select Genre",
                    style: TextStyle(color: Colors.white),
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      ..._selectedChips.map((chip) => InputChip(
                            backgroundColor: Colors.orange,
                            label: Text(chip),
                            onDeleted: () {
                              setState(() {
                                _selectedChips.remove(chip);
                              });
                            },
                          )),
                      InputChip(
                        backgroundColor: Colors.orange,
                        label: Icon(Icons.add),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await _getGenres();
                          setState(() {
                            _isLoading = false;
                          });
                          (context as Element).markNeedsBuild();
                          showModalBottomSheet(
                            backgroundColor: Colors.black,
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Column(
                                  children: [
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      children: _genres
                                          .map(
                                            (genre) => InputChip(
                                              selected: _selectedChips
                                                  .contains(genre),
                                              selectedColor: Colors.yellow,
                                              label: Text(genre),
                                              onSelected: (bool isSelected) {
                                                setState(() {
                                                  if (isSelected) {
                                                    _selectedChips.add(genre);
                                                  } else {
                                                    _selectedChips
                                                        .remove(genre);
                                                  }
                                                });
                                                (context as Element)
                                                    .markNeedsBuild();
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedChips.clear();
                                            });
                                            (context as Element)
                                                .markNeedsBuild();
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        SizedBox(width: 16.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  if (_isLoading)
                    CircularProgressIndicator(
                      strokeWidth: 5.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                ],
              ),
              SizedBox(height: 32.0),
              Text(
                'Performance type',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 22.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                    fillColor: MaterialStatePropertyAll(Colors.orange),
                    value: _isPersonSelected,
                    onChanged: (value) {
                      setState(() {
                        _isPersonSelected = value!;
                        if (_isPersonSelected) {
                          _isVirtualSelected = false;
                        }
                      });
                    },
                  ),
                  Text(
                    'Person',
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    fillColor: MaterialStatePropertyAll(Colors.orange),
                    value: _isVirtualSelected,
                    onChanged: (value) {
                      setState(() {
                        _isVirtualSelected = value!;
                        if (_isVirtualSelected) {
                          _isPersonSelected = false;
                        }
                      });
                    },
                  ),
                  Text('Virtual', style: TextStyle(color: Colors.white)),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Form submitted'),
                          content:
                              Text('Your form has been submitted successfully'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
