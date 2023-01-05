import 'package:batch_student_starter/model/student.dart';
import 'package:batch_student_starter/repository/student_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motion_toast/motion_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Student> _lststudents = [];

  final _usernameController = TextEditingController(text: 'NirajanG');
  final _passwordController = TextEditingController(text: 'Nirajan123');

  @override
  void initState() {
    super.initState();
  }

  _loginUser() async {
    try {
      Student? status = await StudentRepositoryImpl()
          .loginstudent(_usernameController.text, _passwordController.text);
      if (status != null) {
        MotionToast.success(
            description: const Text("Success"),
            onClose: () {
              Navigator.of(context).pushNamed('/dashboardScreen');
            }).show(context);
      } else {
        throw Exception('Error logging in');
      }
    } catch (e) {
      MotionToast.error(
        description: const Text("Username or Password Invalid"),
      ).show(context);
    }
  }

  _showMessage(bool CheckLogin) {
    CheckLogin == true
        ? MotionToast.success(
            description: const Text("Succes"),
            onClose: () {
              Navigator.of(context).pushNamed('/dashboardScreen');
            }).show(context)
        : MotionToast.error(
            description: const Text("failed to login"),
          ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _usernameController,
                      onSaved: (newValue) {
                        setState(() {
                          _usernameController.text = newValue!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        print("running");
                        if (_formKey.currentState!.validate()) {
                          _loginUser();
                          // print("run");

                          //     .then((value) => getStudent);
                          // Navigator.of(context).pushNamed('/dashboardScreen');

                        }
                      },
                      child: const SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registerScreen');
                      },
                      child: const SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
