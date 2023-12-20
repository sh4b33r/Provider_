// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/controller/controller_main.dart';
import 'package:provider_app/model/model.dart';


import '../theme/themes.dart';

class EditScreen extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String std;
  final String photo;
  final int? id;

  EditScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.place,
      required this.std,
      required this.age,
      required this.photo});

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _stdcontroller = TextEditingController();
  final TextEditingController _placecontroller = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyScreenController>();
    _namecontroller.text = name;
    _namecontroller.text = name;
    _agecontroller.text = age;
    _stdcontroller.text = std;
    _placecontroller.text = place;
    controller.image = context.read<MyScreenController>().image;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Clr.appbar,
        leading: IconButton(
            onPressed: () {
              controller.image = '';
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text(
          "Edit Student",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 20, right: 30, bottom: 40),
        child: Container(
          height: 700,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 40,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 235, 249, 227),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: _namecontroller,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _formKey1.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r"^[a-zA-Z][a-zA-Z\- ]{2,28}$")
                                .hasMatch(value.trim())) {
                          return "Enter a Valid name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _agecontroller,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _formKey1.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a Valid age ";
                        } else if (!RegExp(r"^([4-9]|1[0-9]|2[0-5])$")
                            .hasMatch(value)) {
                          return "Enter age Between 4 and 25";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _stdcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Standard',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _formKey1.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a Valid standard ";
                        } else if (!RegExp(r"^([1-9]|1[0-2])$")
                            .hasMatch(value)) {
                          return "Enter a Standard Below 12";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: _placecontroller,
                      decoration: const InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _formKey1.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r"^[a-zA-Z0-9\- ]{1,20}$")
                                .hasMatch(value)) {
                          return "Enter a Valid Place ";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await controller.pickImage();
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Select a Profile Photo'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
      
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: context.watch<MyScreenController>().image.isNotEmpty
                        ? Image.file(File(context.watch<MyScreenController>().image))
                        : const Text(
                            'Please Select An Image From Gallery',
                            textAlign: TextAlign.center,
                          ),
                  ),
      
                  //   },
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey1.currentState!.validate() &&
                          controller.image.isNotEmpty) {
                        final data = StudentModel(
                            name: _namecontroller.text,
                            age: _agecontroller.text,
                            photo: controller.image,
                            std: _stdcontroller.text,
                            id: id,
                            place: _placecontroller.text);
      
                        await controller.editStudents(data);
      
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Data Updated Succesfully',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(milliseconds: 1500),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color.fromARGB(255, 14, 201, 24),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Failed to Add',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(milliseconds: 1500),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color.fromARGB(255, 216, 34, 13),
                          ),
                        );
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
