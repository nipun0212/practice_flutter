import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_flutter/login/otp.dart';
import 'phoneNumberLogin.dart';
import '../sample.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isLoggedIn;
  String _phoneNumber = "";
  String _verificationId = "";
  final _formKey = GlobalKey<FormState>();

  Future<bool> isAlreadySignedIn() async {
    FirebaseUser user = await _auth.currentUser();
    print("user?.phoneNumber");
    print(user?.phoneNumber);
    if (user != null) return true;
    return false;
  }

  @override
  void initState() {
    print("In state");
    super.initState();
    isAlreadySignedIn().then((v) => {
          setState(() {
            _isLoggedIn = v;
            print(_isLoggedIn);
          })
        });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn != null && _isLoggedIn == true) {
      return Counter();
    } else
      return Scaffold(
          appBar: AppBar(title: Text("Login")),
          body: Container(
//            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      size: 48.0,
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Text(
                      "Enter Your Phone Number",
                      textScaleFactor: 2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "+91 ",
                      textScaleFactor: 2,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: 175,
                          child: TextFormField(
                            validator: (v) {
                              print("in val");
                              return "invalid";
                            },
                            keyboardAppearance: Brightness.dark,
                            style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLength: 10,
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: false, signed: false),
                            decoration: InputDecoration(),
                            onChanged: (v) {
                              setState(() {
                                _phoneNumber = v;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () async {
                      print("pressd");
                      print(_phoneNumber);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+91" + _phoneNumber,
                          timeout: Duration(seconds: 5),
                          codeSent: (v, [int i]) {
                            print("codesent to " + _phoneNumber);
                            _verificationId = v;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTP(
                                        phoneNumber: _phoneNumber,
                                        verificationId: _verificationId,
                                      )),
                            );
                          },
                          verificationFailed: (AuthException error) {
                            print("error1");
                            print(error.message);
                            Fluttertoast.showToast(
                                msg: "You are not connected to internet",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                textColor: Colors.white,
                                backgroundColor: Colors.red,
                                fontSize: 12.0
                            );
                          });
                    },
                    color: Colors.green,
                    child: Text("Get OTP"),
                    elevation: 2,
                  ),
                )
              ],
            ),
          ));
  }
}
