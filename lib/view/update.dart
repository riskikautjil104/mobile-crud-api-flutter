import 'package:api_dummy/models/api_dummy.dart';
import 'package:flutter/material.dart';

class UpdateUser extends StatelessWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
        actions: [Icon(Icons.account_balance_wallet)],
      ),
      body: HomeUpdate(),
    );
  }
}

class HomeUpdate extends StatefulWidget {
  const HomeUpdate({super.key});

  @override
  State<HomeUpdate> createState() => _HomeUpdatePageState();
}

class _HomeUpdatePageState extends State<HomeUpdate> {
  Repository repository = Repository();
  final _createController = TextEditingController();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();
  final _idController = TextEditingController();

  Future<void> _UpdateNow() async {
    final createdAt = _createController.text;
    final name = _nameController.text;
    final avatar = _avatarController.text;
    final id = _idController.text;

    // validasi input
    if (createdAt.isEmpty || name.isEmpty || avatar.isEmpty || id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal Menambahkan"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // kirim data
    final response =
        await repository.puData(int.parse(id), createdAt, name, avatar);

    if (response) {
      Navigator.of(context).popAndPushNamed('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('data gagal di update'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // memnampilkan kalender
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
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;

    if (args[1].isNotEmpty) {
      _nameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _createController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      _avatarController.text = args[3];
    }
    if (args[0].isNotEmpty) {
      _idController.text = args[0];
    }
    return Center(
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
                onPressed: _UpdateNow,
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
                  "Update",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 228, 146),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
