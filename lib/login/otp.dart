import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:practice_flutter/sample.dart';

class OTP extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;
  String _otp = "";

  OTP({Key key, @required this.phoneNumber, @required this.verificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("phoneNumber" + phoneNumber);
    print("phoneNumber" + verificationId);
    return Scaffold(
        appBar: AppBar(
          title: Text("OTP"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Please enter OTP received on")),
            Text("+91" + phoneNumber),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: PinInputTextFormField(
                onChanged: (v) async {
                  AuthResult result = null;
                  if (v.length == 6) {
                    result = await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.getCredential(
                      verificationId: verificationId,
                      smsCode: v,
                    ));

                    print("result");
                    print(result);
                    if(result!=null){
                      Navigator.pushNamed(context, '/counter');
                    }
                  }
//                  if (v.length == 7) {
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => Counter()));
//                  }
                },
                pinLength: 6,
                keyboardType: TextInputType.number,
                decoration: BoxLooseDecoration(
                  enteredColor: Colors.green,
                  strokeWidth: 2,
                  radius: Radius.circular(4),
                ),
                enabled: true,
//              controller: _pinEditingController,
                autoFocus: true,
                textInputAction: TextInputAction.go,
//                autovalidate:true,
//                onSubmit: (pin) async {
//                  print(pin);
//                  debugPrint('submit pin:$pin');
//                  print("nipun");
//                  AuthResult result = await FirebaseAuth.instance
//                      .signInWithCredential(PhoneAuthProvider.getCredential(
//                    verificationId: verificationId,
//                    smsCode: pin,
//                  ));
//                  print(result.user.phoneNumber);
//                },
              ),
            )
          ],
        ));
  }
}
