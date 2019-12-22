import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/login');
    setState(() {
      ++_counter;
      ++_counter;
    });
  }
  Future<String> phoneNumber() async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    return user.phoneNumber;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Registration"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').  snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print("nipun");
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return  ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return  ListTile(
                    title: new Text(document['phone_number']),
                    subtitle: new Text(document['name']),
                    onTap: ()=>_increment(),
                  );
                }).toList(),
              );
          }
        },
      )
    );
  }
}
