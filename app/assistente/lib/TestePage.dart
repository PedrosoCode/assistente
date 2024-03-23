import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TestePage extends StatefulWidget {
  @override
  _TestePageState createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {
  List notebooks = [];

  @override
  void initState() {
    super.initState();
    fetchNotebooks();
  }

  fetchNotebooks() async {
    var url = Uri.parse('http://localhost:8080/notebooks');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      setState(() {
        notebooks = data;
      });
    } else {
      print('Failed to load notebooks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
      body: ListView.builder(
        itemCount: notebooks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notebooks[index]['modelo']),
            subtitle: Text(
                '${notebooks[index]['cor']} - ${notebooks[index]['nome_dono']}'),
          );
        },
      ),
    );
  }
}
