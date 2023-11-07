import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:watsap_app/views/home.dart';
import 'package:watsap_app/views/registerscreen.dart';

// ignore: must_be_immutable
class Loginscreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<User?> _login(String email, String pass, context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        user = userCredential.user;
        
        print("aisha");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homeview()));

        print('login');

        // You can handle the successful login here, e.g., navigate to the home page.
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else {
          print('Error: ${e.message}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                     decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "E-mail",
                      ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                     decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "password",
                      ),
                    
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    _login(_emailController.text, _passwordController.text,
                        context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Homeview()));
                  },
                  child: Text("login ")),
              Text(
                "------------------------------------------------------------------",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registerscreen()));
                  },
                  child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
