// import 'package:api_dummy/models/api_dummy.dart';
// import 'package:flutter/material.dart';

// class AddUser extends StatefulWidget {
//   const AddUser({super.key});

//   @override
//   State<AddUser> createState() => _AddUserState();
// }

// class _AddUserState extends State<AddUser> {
//   Repository repository = Repository();
//   final _createController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _avatarController = TextEditingController();
//   final _idController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add User"),
//         backgroundColor: Color.fromARGB(255, 110, 84, 7),
//       ),
//       body: Center(
//         child: Container(
//           alignment: Alignment.center,
//           width: 300,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: _createController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'createdAt',
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'name',
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: _avatarController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'avatar',
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: _idController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'id',
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   // onHover: (value) {},
//                   onPressed: () async {
//                     bool response = await repository.postData(
//                         _createController.text,
//                         _nameController.text,
//                         _avatarController.text,
//                         _idController.text);
//                     if (response) {
//                       Navigator.of(context).pushNamed('/');
//                     } else {
//                       print("post data gagal");
//                     }
//                   },
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                           Color.fromARGB(255, 110, 84, 7))),
//                   child: Text(
//                     "Submit",
//                     // textDirection: Te,
//                     style: TextStyle(
//                       color: const Color.fromARGB(255, 255, 228, 146),
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:api_dummy/models/api_dummy.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Repository repository = Repository();
  final _createController = TextEditingController();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();
  final _idController = TextEditingController();

  Future<void> _submitForm() async {
    final createdAt = _createController.text;
    final name = _nameController.text;
    final avatar = _avatarController.text;
    final id = _idController.text;

    // Validasi input
    if (createdAt.isEmpty || name.isEmpty || avatar.isEmpty || id.isEmpty) {
      // Menampilkan pesan kesalahan jika ada input yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua kolom harus diisi.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Kirim data ke server
    final response = await repository.postData(createdAt, name, avatar, id);

    if (response) {
      Navigator.of(context).popAndPushNamed('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan pengguna.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // menambah tanggal
  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    // ignore: unnecessary_null_comparison
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _createController.text = selectedDate!
            .toIso8601String(); // Mengisi TextField dengan tanggal yang dipilih
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        backgroundColor: Color.fromARGB(255, 110, 84, 7),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 300,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _createController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'createdAt',
                  suffixIcon: IconButton(
                    onPressed: () => _selectDate(context),
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                cursorColor: Color.fromARGB(255, 184, 178, 2),
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 181, 181, 0),
                      fontWeight: FontWeight.bold),
                  fillColor: Colors.amber,
                  focusColor: Colors.deepPurpleAccent,
                  hoverColor: Colors.orange,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 129, 10,
                          2), // Ubah warna border sesuai keinginan Anda
                    ),
                  ),
                  labelText: 'name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _avatarController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'avatar',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'id',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                clipBehavior: Clip.antiAlias,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(
                          const Color.fromARGB(255, 255, 255, 254)),
                      // shadowColor: MaterialStateProperty(),
                      // shadowColor: ,
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 110, 84, 7),
                      ),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)))),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 228, 146),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
