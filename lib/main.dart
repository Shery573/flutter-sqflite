import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqf_lite/controller.dart';
import 'Person.dart';
import 'PersonDB.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          hintStyle: GoogleFonts.lexendDeca(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
          border: OutlineInputBorder(
              // borderSide: const BorderSide(
              //   color: Theme.of(context).colorSc,
              //   width: 2,
              // ),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: Home(),
    );
  }
}

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  // ignore: prefer_typing_uninitialized_variables
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Operations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
        stream: controller.crudStorage.all(),
        builder: (context, snapshot) {
          print(snapshot);
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final people = snapshot.data as List<Person>;
              print(people);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller.first_name,
                            decoration: const InputDecoration(
                              hintText: 'Enter first name',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller.last_name,
                            decoration: const InputDecoration(
                              hintText: 'Enter last name',
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                      Theme.of(context)
                                          .colorScheme
                                          .inversePrimary)),
                          onPressed: () {
                            controller.addToList(
                              controller.first_name.text,
                              controller.last_name.text,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Add to List',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: people.length,
                        itemBuilder: (context, index) {
                          final person = people[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onLongPress: () {
                                controller.handleUpdate(context, person);
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              tileColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              title: Center(
                                child: Text(person.fullName),
                              ),
                              subtitle: Center(
                                child: Text('ID: ${person.id.toString()}'),
                              ),
                              trailing: IconButton(
                                iconSize: 25,
                                color: Theme.of(context).colorScheme.onTertiary,
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () async {
                                  controller.handleDelete(context, person);
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
