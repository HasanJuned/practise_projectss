import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedOptions;

  Map<String, dynamic> options = {'flutter': 0, 'java': 0, 'c': 0, 'mern': 0};

  void calculateVote() {
    options[selectedOptions!]++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vote'),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.camera))],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            ...options.keys.map((index) {
              return RadioListTile(
                title: Text(index),
                value: index,
                groupValue: selectedOptions,
                onChanged: (x) {
                  selectedOptions = x;
                  calculateVote();
                  setState(() {});
                },
              );
            }),
            ...options.entries.map((x) {
              return Text('${x.key} ${x.value}');
            }),

            ElevatedButton(
              onPressed: () {
                int max = 0;

                String? winner = 'no one';

                options.forEach((key, value) {
                  if (value > max) {
                    max = value;
                    winner = key;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Winner: $winner'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: Text('Result'),
            ),
          ],
        ),
      ),
    );
  }
}
