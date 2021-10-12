import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(FacebookApp());
}

class FacebookApp extends StatefulWidget {
  FacebookApp({Key? key}) : super(key: key);

  @override
  _FacebookAppState createState() => _FacebookAppState();
}

class _FacebookAppState extends State<FacebookApp> {
  Map? _userData;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Facebool (Logged out)"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text("Log In"),
                onPressed: () async {
                  final result = await FacebookAuth.i
                      .login(permissions: ["public_profile", "email"]);
                  if (result.status == LoginStatus.success) {
                    final requestData = await FacebookAuth.i.getUserData(
                      fields: "email,name",
                    );
                    setState(() {
                      _userData = requestData;
                    });
                  }
                },
              ),
              ElevatedButton(
                child: Text("Log Out"),
                onPressed: () async {
                  await FacebookAuth.i.logOut();
                  setState(() {
                    _userData = null;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
