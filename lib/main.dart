import 'package:flutter/material.dart';
import 'package:flutter_exam4/data_repository.dart';
import 'package:flutter_exam4/dog.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        child: MyApp(),
        providers: [
          Provider<DataRepository>(
            create: (_) => DataRepository(),
          ),
        ],
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Dog> _dogs = [];

  DataRepository _repository;

  @override
  void initState() {
    super.initState();

    _repository = Provider.of<DataRepository>(context, listen: false);

    setState(() {
      // 비동기 요청 했다 치고
      _dogs = [
        Dog('멍멍이', age: 10, sex: '수컷', type: '똥개'),
        Dog('바둑이', age: 15, sex: '암컷', type: '진돗개'),
        Dog('백구', age: 12, sex: '수컷', type: '삽살개'),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('first page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: _dogs.map((dog) => _buildListTile(dog)).toList(),
      ),
    );
  }

  ListTile _buildListTile(Dog dog) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(dog.name),
      trailing: Checkbox(
        value: _repository.dogs.contains(dog),
        onChanged: (bool value) {
          setState(() {
            if (value) {
              _repository.dogs.add(dog);
            } else {
              _repository.dogs.remove(dog);
            }
          });
        },
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<DataRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('second'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('어쩌구'),
            Text('저쩌구'),
            Icon(
              Icons.home,
              size: 40,
            ),
            ...repository.dogs.expand((dog) => _buildDog(dog)).toList(),
            Divider(),
            Text('어쩌구'),
            Text('저쩌구'),
            Icon(
              Icons.home,
              size: 40,
            ),
            Text('어쩌구'),
            Text('저쩌구'),
            Icon(
              Icons.home,
              size: 40,
            ),Text('어쩌구'),
            Text('저쩌구'),
            Icon(
              Icons.home,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDog(Dog dog) {
    return [
      Divider(),
      Icon(Icons.person),
      Text(dog.name),
      Text('${dog.age}세'),
      Text(dog.type),
    ];
  }
}
