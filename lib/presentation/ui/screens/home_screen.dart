import 'package:flutter/material.dart';

import '../../../data/local_cache/information_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  late InformationController informationController;
  List<String> list = [];


  @override
  void initState() {
    super.initState();
    informationController = InformationController();
    _loadData();
  }

  Future<void> _loadData() async {
    await informationController.getData();
    list = informationController.list;
  }

  Future<void> addData() async {

    list.addAll([_nameController.text, _numberController.text]);
    await informationController.setData(list);
    setState(() {});

    _nameController.clear();
    _numberController.clear();
  }

  removeItem(int index) {
    list.removeAt(index);
    setState(() {});
    informationController.setData(list);
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
          spacing: 4,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(hintText: "Subtitle"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: addData, child: const Text('Save'))),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await informationController.removeAllData();
                  await informationController.getData();
                  setState(() {});
                },
                child: const Text('Remove all'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      removeItem(index);
                    },
                    child: ListTile(title: Text(list[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
