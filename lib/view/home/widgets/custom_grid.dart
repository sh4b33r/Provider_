import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/controller/controller_main.dart';
import 'package:provider_app/view/detailed_view/detailed_view.dart';
import 'package:provider_app/view/edit/edit_screen.dart';

class CustomGridview extends StatelessWidget {
  const CustomGridview({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MyScreenController>(
      builder: (context, MyScreenController value, child) {
        return value.studentListNot.isEmpty
            ? const Center(
                child: Text(
                  "No data",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                children: List.generate(value.studentListNot.length, (index) {
                  final data = value.studentListNot[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => DetailedView(value: data)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 166, 221, 177),
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            data.photo.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(data.photo)),
                                      radius: 43,
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 35,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                data.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      context.read<MyScreenController>().image =
                                          data.photo;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => EditScreen(
                                                  id: data.id,
                                                  name: data.name,
                                                  place: data.place,
                                                  std: data.std,
                                                  age: data.age,
                                                  photo: data.photo)));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Delete?"),
                                            content: const Text(
                                                "Deleted Items can't be Retrieved"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel")),
                                              TextButton(
                                                  onPressed: () {
                                                    value.deleteData(data.id);
                                                      Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
      },
    );
  }
}
