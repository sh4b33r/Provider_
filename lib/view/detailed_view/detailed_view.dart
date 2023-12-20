import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider_app/model/model.dart';
import 'package:provider_app/view/theme/themes.dart';

class DetailedView extends StatelessWidget {
  final StudentModel value;
 const DetailedView({super.key,required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor:Clr.appbar),
      
      body: ListView(
        children: [
          Padding(
            
            padding: const EdgeInsets.all(40.0),
            child: Container(
              color: const Color.fromARGB(255, 243, 241, 231),
              height: 600,
              width: 500,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    // imageProfileWidgetc,
                    CircleAvatar(backgroundImage: FileImage(File(value.photo)),radius: 50,),
                    const SizedBox(height: 50,),
                    Text(
                      'Name : ${value.name}',
                      style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'Age :  ${value.age}',
                      style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'Place :  ${value.place}',
                      style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'Standard :${value.std}',
                      style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}