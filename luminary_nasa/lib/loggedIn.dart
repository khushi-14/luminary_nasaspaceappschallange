import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luminary_nasa/google_sign_in_button.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 14, 31, 56);
    const mainColor = Color.fromARGB(255, 0, 9, 25);
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.grey[300],
      minimumSize: Size(100, 50),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Container(
            alignment: Alignment.center,
            color: mainColor,
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 16.0,
                  bottom: 90.0,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '',
                        style:
                            TextStyle(fontSize: 32, color: Color(0xffd7dae0)),
                      ),
                      SizedBox(height: 55),
                      CircleAvatar(
                        radius: 90,
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                      SizedBox(height: 20),
                      Text(
                        user.displayName!,
                        style:
                            TextStyle(color: Color(0xffd7dae0), fontSize: 26),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 26),
                        ),
                        style: raisedButtonStyle,
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.logout();
                        },
                      )
                    ]))));
  }
}
