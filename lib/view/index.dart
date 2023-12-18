import 'package:api_dummy/models/api_dummy.dart';
import 'package:api_dummy/models/model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<User> listUser = [];
Repository repository = Repository();

getData() async {
  listUser = await repository.getData();

  // ignore: unused_element
  // setState(() {});
}

// void setState(Null Function() param0) {}
// show dialog

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listUser.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/update-user', arguments: [
                listUser[index].id,
                listUser[index].name,
                listUser[index].createdAt,
                listUser[index].avatar,
              ]);
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      listUser[index].name,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 221, 177, 2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      listUser[index].createdAt,
                      style: TextStyle(fontSize: 10.0),
                    ),
                    leading: ClipOval(
                      child: Image.network(
                        listUser[index].avatar,
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () async {
                          bool response =
                              await repository.deleteData(listUser[index].id);
                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('berhasil dihapus'),
                                backgroundColor:
                                    Color.fromARGB(255, 1, 26, 255),
                              ),
                            );
                            getData();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('data dihapus'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            // print('data gagal di delete');
                          }
                          getData();
                        },
                        icon: Icon(Icons.delete)),
                  )
                ],
              ),
            ),
          );
        });
  }
}
