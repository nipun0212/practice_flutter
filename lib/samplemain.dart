import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'sample.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("filled background");
              }),
          appBar: AppBar(
              title: Text(
                "Flutter Demo",
              )),
          body: PhoneNumber()),
      title: "My APP",
    );
  }
}

class ShowNineOne extends StatelessWidget {
  ShowNineOne(this.fontSize);

  final fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22.0),
      decoration: BoxDecoration(
//          border: Border.all(),
          color: Colors.white),
      child: Text(
        "+91",
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

Widget ImageSection = SizedBox(
  height: 100.0,
  width: 100.0,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Column(
        children: <Widget>[
          Image.asset(
            "Images/antique-black-blur-163007.jpg",
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          )
        ],
      )
    ],
  ),
);

class PhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//        padding: EdgeInsets.only(left: 70, bottom: 50),
//        alignment: Alignment.bottomCenter,
        color: Colors.white,
        child: ListView(
          children: <Widget>[
//            ImageSection,
            SizedBox(
              height: 50,
            ),
            PhoneNumberLine(18.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[ShowNineOne(40.0)],
                    ),
                  ),
                  Column(
                    children: <Widget>[PhoneNumberInput()],
                  )
                ]),
          ],
        ));
  }
}

class EnterOTP extends StatefulWidget {
  String verificationId;

  @override
  _EnterOTPState createState() => _EnterOTPState();

  EnterOTP({Key key, this.verificationId}) : super(key: key);
}

class _EnterOTPState extends State<EnterOTP> {
  FirebaseUser user;

  void _signInWithPhoneNumber(String smsCode) async {
    print(widget.verificationId);
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );
    print("nipun");
    print((await FirebaseAuth.instance.signInWithCredential(credential)).user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 6,
            onChanged: (val) {
              if (val.length == 6) {
                _signInWithPhoneNumber(val);
              }
            },
          )
        ],
      ),
    );
  }
}

//class PhoneNumber extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          Column(
//            children: <Widget>[PhoneNumberInput()],
//          ),
//          Column(
//            children: <Widget>[ShowNineOne(40.0)],
//          )
//        ],
//      ),
//    );
//  }
//}

Widget PhoneNumberLine(fontSize) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.phone,
            size: 40.0,
            color: Colors.black26,
          ),
          Text(
            " Please enter your Mobile Number",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );

class PhoneNumberText extends StatelessWidget {
  PhoneNumberText(this.fontSize);

  final fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.phone,
            size: 40.0,
            color: Colors.black26,
          ),
          Text(
            " Please enter your Mobile Number",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneNumberInput extends StatefulWidget {
  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  String _phoneNumber = "";
  bool containFive = false;
  String verificationId;

  Future<void> _sendCodeToPhoneNumber() async {
    print("Function Called");
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("code sent to " + _phoneNumber);
//      _signInWithPhoneNumber('123456');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + _phoneNumber,
        timeout: const Duration(seconds: 5),
        codeSent: codeSent,
        verificationCompleted: (val) {
          print("Completed");
          print(val);
        });
    print("Function Called2");
  }

  void _signInWithPhoneNumber(String smsCode) async {
    print(verificationId);
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: '123456',
    );
    print("nipun");
    print((await FirebaseAuth.instance.signInWithCredential(credential)).user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//      decoration: BoxDecoration(border: Border.all(), color: Colors.white),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 300.0,
              child: TextFormField(
                style: (containFive
                    ? TextStyle(fontSize: 100, fontWeight: FontWeight.bold)
                    : TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                maxLength: 10,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  print(val);
                  _phoneNumber = val;
                  setState(() {
                    if (val.endsWith('5')) {
                      containFive ? containFive = false : containFive = true;
                    }
                    if (val.length == 10) {
                      _sendCodeToPhoneNumber();
//                  _signInWithPhoneNumber('123');
                    }
                    _phoneNumber = val;
                  });
                },
              ),
            ),
            Text('$_phoneNumber'),
            Text('phoneNumber'),
            SizedBox(
                width: 100.0,
                child: EnterOTP()),

          ],
        ));
  }
}

class PhoneNumberInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
//                Text(
//                  "Enter your Mobile Number",
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
                NumberOutput(),
              ],
            ),
            Column(
              children: <Widget>[
//                Text(
//                  "Enter your Mobile Number",
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
                NumberOutput(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberOutput extends StatefulWidget {
  @override
  _NumberOutputState createState() => _NumberOutputState();
}

class _NumberOutputState extends State<NumberOutput> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        width: 20,
        child: TextFormField(
          maxLength: 10,
        ),
      ),
    );
  }
}

//class NumberInput extends StatefulWidget {
//  @override
//  _NumberInputState createState() => _NumberInputState();
//}

//class _NumberInputState extends State<NumberInput> {
//  final _formKey = GlobalKey<FormState>();
//  String _phoneNumber = "";
//
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      key: _formKey,
//      child: Container(
//        child: Column(
//          children: <Widget>[
//            TextFormField(
//                initialValue: "+91 ",
//                keyboardType: TextInputType.number,
//                validator: (val) {
//                  if (val.isEmpty) {
//                    return 'Please enter some text';
//                  }
//                  return null;
//                  print("validating");
//                },
//                maxLength: 10,
//                onSaved: (val) {
//                  print(val);
//                  setState(() {
//                    print(val);
//                    _phoneNumber = val;
//                  });
//                }),
//            RaisedButton(
//              child: Text("Submit"),
//              color: Colors.deepOrange,
//              onPressed: () {
//                if (_formKey.currentState.validate()) {
//                  // If the form is valid, display a Snackbar.
//                  Scaffold.of(context).showSnackBar(
//                      SnackBar(content: Text('Processing Data')));
//                }
//                print("ssd");
////              _formKey.currentState.save();
////              print(_phoneNumber);
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Text("Enter your Number"), MyCustomFomr()],
    );
  }
}

class MyCustomFomr extends StatefulWidget {
  @override
  _MyCustomFomrState createState() => _MyCustomFomrState();
}

class _MyCustomFomrState extends State<MyCustomFomr> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please enter some text';
//              }
//              return null;
//            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
