import 'package:flutter/material.dart';
import 'package:practise_project_ostadd/data/local_cache/information_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  late InformationController informationController;
  List<Map<String, String>> list = [];

  @override
  void initState() {
    super.initState();
    informationController = InformationController();
    _loadData();
  }

  Future<void> _loadData() async {
    await informationController.getData();
    setState(() {

    });
    list = informationController.list;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "title",
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _subtitleController,
              decoration: const InputDecoration(
                hintText: "subtitle",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addData,
                child: const Text('Save'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  removeAllData();
                },
                child: const Text('Remove All'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(list[index]["title"] ?? ""),
                    subtitle: Text(list[index]["subtitle"] ?? ""),
                    trailing: IconButton(onPressed: (){
                      removeSingleData(index);
                    }, icon: Icon(Icons.delete)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addData() async {

    Map<String, String> entry = {
      "title": _titleController.text,
      "subtitle": _subtitleController.text,
    };

    list.add(entry);

    await informationController.setData(list);
    setState(() {});

    _titleController.clear();
    _subtitleController.clear();
  }

  void removeSingleData(int index) async{
    list.removeAt(index);
    setState(() {

    });
    await informationController.setData(list);
  }

  void removeAllData() async{
    await informationController.removeAllData();
    _loadData(); /// recall the load data
    setState(() {

    });
  }
}
