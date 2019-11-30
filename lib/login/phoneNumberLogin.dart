import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice_flutter/login/otp.dart';

Widget ShowNineOne(fontSize) => Container(
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

Widget PhoneNumberLine(fontSize) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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

class PhoneNumberLogin extends StatefulWidget {
  @override
  _PhoneNumberLoginState createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {
  String _phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        PhoneNumberLine(17.0),
        Row(
          children: <Widget>[
            ShowNineOne(40.0),
            SizedBox(
              width: 300.0,
              child: TextFormField(
                style: (TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                maxLength: 10,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  print(val);
                  if (val.length == 10) {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTP(phoneNumber: _phoneNumber),
                        ),
                      );
                      _phoneNumber = val;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

class PhoneNumberInput extends StatefulWidget {
  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
      child: FractionallySizedBox(
        widthFactor: .5,
        child: TextFormField(
          maxLength: 10,
        ),
      ),
    );
  }
}
