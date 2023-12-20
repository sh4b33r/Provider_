// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/controller/controller_main.dart';
import '../../model/model.dart';
import '../theme/themes.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});
  final TextEditingController _nameCont = TextEditingController();
  final TextEditingController _ageCont = TextEditingController();
  final TextEditingController _stdCont = TextEditingController();
  final TextEditingController _placeCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _name = GlobalKey<FormFieldState>();
  final _age = GlobalKey<FormFieldState>();
  final _std = GlobalKey<FormFieldState>();
  final _place = GlobalKey<FormFieldState>();


  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyScreenController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Clr.appbar,
        centerTitle: true,
        title: const Text(
          "Add Student",
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
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      key: _name,
                      controller: _nameCont,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _name.currentState!.validate();
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
                      key: _age,
                      keyboardType: TextInputType.number,
                      controller: _ageCont,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _age.currentState!.validate();
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
                      key: _std,
                      keyboardType: TextInputType.number,
                      controller: _stdCont,
                      decoration: const InputDecoration(
                        labelText: 'Standard',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _std.currentState!.validate();
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
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      key: _place,
                      controller: _placeCont,
                      decoration: const InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _place.currentState!.validate();
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

                  // ChangeNotifierProvider<MyScreenController>(create:(_) => MyScreenController(),
                  //           Consumer<MyScreenController>(
                  // builder: (BuildContext context,MyScreenController model, _) {
                  //   return SizedBox(
                  //               width: 100,
                  //               height: 100,
                  //               // child: value.isNotEmpty
                  //             child: model.image.isNotEmpty
                  //               ? Image.file(File(model.image))
                  //               : const Text(
                  //                   'Please Select An Image From Gallery',
                  //                   textAlign: TextAlign.center,
                  //                 ),
                  //             );

                  // },
                  //           ),

                  SizedBox(
                    width: 100,
                    height: 100,
                    child: controller.image.isNotEmpty
                        ? Image.file(File(controller.image))
                        : const Text(
                            'Please Select An Image From Gallery',
                            textAlign: TextAlign.center,
                          ),
                  )

               

                  ,
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          controller.image.isNotEmpty) {
                        final data = StudentModel(
                            name: _nameCont.text,
                            age: _ageCont.text,
                            photo: controller.image,
                            std: _stdCont.text,
                            place: _placeCont.text);

                        await context.read<MyScreenController>().addStudents(data);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Data Added Succesfully',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(milliseconds: 1500),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color.fromARGB(255, 14, 201, 24),
                          ),
                        );
                     
                          _nameCont.clear();
                          _ageCont.clear();
                          _placeCont.clear();
                          _stdCont.clear();
                          context.read<MyScreenController>().clearimage();
                       
                           
                        
                        //   clear();
                      } else if (controller.image.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(milliseconds: 1500),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color.fromARGB(255, 216, 34, 13),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(milliseconds: 1500),
                          content: Text(
                            "Fill  all fields as required",
                            style: TextStyle(color: Colors.white),
                          ),
                        ));
                      }
                    },
                    child: const Text('Add'),
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
