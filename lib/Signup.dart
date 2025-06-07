import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login.dart';
import 'authentication.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _key = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late Authentication auth;
  String? errorMessage = '';
  Widget printErrorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      style: TextStyle(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<Authentication>(context);
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
                    width: 200,
                    child: Image(
                      image: AssetImage('lib/images/logo.jpg'),
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    controller: usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF520C2E),
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Enter Username",
                      label: Text(
                        "Username",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
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
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Password';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
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
                        borderSide: BorderSide(
                          color: Colors.pinkAccent, // Borde
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 27),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          passwordController.text.trim() != value) {
                        return 'Please re-enter your Password';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF520C2E),
                      icon: Icon(Icons.password, color: Colors.white),
                      hintText: "Re-Enter Password",
                      label: Text(
                        "Confirm Password",
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
                  SizedBox(height: 50),
                  Container(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEBE9E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF520C2E),
                        ),
                      ),
                      onPressed: () {
                        if (_key.currentState?.validate() ?? false) {
                          signUpUser();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      "Already have an account? Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  printErrorMessage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUpUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final username = usernameController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
      try {
        await auth.signUp(email: email, password: password, username: username);

        // Navigate to home page on successful signup
        Navigator.pushNamed(context, '/home');
      } catch (error) {
        setState(() {
          errorMessage = 'Unexpected error: ${error.toString()}';
        });
      }
    }
  }
}
