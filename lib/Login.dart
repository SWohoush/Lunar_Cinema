import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Signup.dart';
import 'authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage = '';
  Widget printErrorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      style: TextStyle(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF520C2E),
      body: SizedBox.expand(
        child: Center(
          child: Container(
            width: 300,
            child: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 225,
                    child: Image(
                      image: AssetImage('lib/images/logo.jpg'),
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter email';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF520C2E),
                      icon: Icon(Icons.email, color: Colors.white),
                      hintText: "Enter Email",
                      label: Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white, // Change hint text color here
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide(
                          color: Colors.pinkAccent, // Borde
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 27),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF520C2E),
                      icon: Icon(Icons.password, color: Colors.white),
                      hintText: "Enter Password",
                      label: Text(
                        "Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white, // Change hint text color here
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide(color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFEBE9E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF520C2E),
                        ),
                      ),
                      onPressed: () {
                        if (_key.currentState!.validate()) signUserIn();
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  printErrorMessage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUserIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      bool success = await Provider.of<Authentication>(
        context,
        listen: false,
      ).signIn(email: email, password: password);

      if (success) {
        Navigator.pushNamed(
          context,
          '/home', // Navigate if sign-in is successful
        );
      } else {
        setState(() {
          errorMessage = "Please try to Sign In again.";
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Unexpected error: ${error.toString()}';
      });
    }
  }
}
