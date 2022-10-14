
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/homecontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Authorcontroller authorcontroller = Get.put(Authorcontroller());

  TextEditingController name = TextEditingController();
  TextEditingController img = TextEditingController();
  TextEditingController authname = TextEditingController();
  TextEditingController abauth = TextEditingController();
  TextEditingController abbook = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController pbyear = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Author Book"),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: authorcontroller.readData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            else if (snapshot.hasData) {
              print("============= ${snapshot.data.snapshot}");

              List l1 = [];
              DataSnapshot data = snapshot.data.snapshot;

              for (var x in data.children) {
                BookModel t1 = BookModel(
                  name: x.child("name").value.toString(),
                  img: x.child("img").value.toString(),
                  authname: x.child("authname").value.toString(),
                  abauth: x.child("abauth").value.toString(),
                  abbook: x.child("abbook").value.toString(),
                  rating: x.child("rating").value.toString(),
                  pbyear: x.child("pbyear").value.toString(),
                  key: x.key,);
                l1.add(t1);
              }

              return ListView.builder(
                itemCount: l1.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network("${l1[index].img}"),
                    title: Text("${l1[index].name}"),
                    subtitle: Text("${l1[index].rating}"),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              name = TextEditingController(
                                  text: l1[index].name);
                              img = TextEditingController(
                                  text: l1[index].img);
                              authname = TextEditingController(
                                  text: l1[index].authname);
                              abauth = TextEditingController(
                                  text: l1[index].abauth);
                              abbook = TextEditingController(
                                  text: l1[index].abbook);
                              rating = TextEditingController(
                                  text: l1[index].rating);
                              pbyear = TextEditingController(
                                  text: l1[index].pbyear);
                              DilogeBox(l1[index].key.toString());
                            },
                            icon: Icon(
                              Icons.edit, color: Colors.green.shade400,),
                          ),
                          IconButton(
                            onPressed: () {
                              authorcontroller.delete(l1[index].key!);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () {
            name = TextEditingController();
            img = TextEditingController();
            authname = TextEditingController();
            abauth = TextEditingController();
            abbook = TextEditingController();
            rating = TextEditingController();
            pbyear = TextEditingController();
            DilogeBox(null);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
  void DilogeBox(String? key) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: img,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Image Link",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: authname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Author Name",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: abauth,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "About Author",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: abbook,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "About Book",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: rating,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Rating",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: pbyear,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Publish Year",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authorcontroller.addData(
                            name: name.text,
                            img: img.text,
                            authname: authname.text,
                            abauth: abauth.text,
                            abbook: abbook.text,
                            rating: rating.text,
                            pbyear: pbyear.text,
                            key: key);
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}

