import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_app/controller/controller_main.dart';


class CustomSearchBar extends StatelessWidget {
 final MyScreenController  valcontroller;
  CustomSearchBar( {super.key,required this.valcontroller});

 final TextEditingController searchController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: searchController,
        onChanged: (value) async {
          // await controller.searchStudents(value);
          await valcontroller.searchStudents(value);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                context.read<MyScreenController>().studentsRefresh();
                searchController.clear();
              },
              icon: const Icon(Icons.close)),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          hintText:"Search"
        ),
      ),
    );
  }
}
