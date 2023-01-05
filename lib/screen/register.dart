import 'package:batch_student_starter/data_source/local_data_source.dart/batch_data_source.dart';
import 'package:batch_student_starter/data_source/local_data_source.dart/course_data_source.dart';
import 'package:batch_student_starter/model/courses.dart';
import 'package:batch_student_starter/model/student.dart';
import 'package:batch_student_starter/repository/course_repo.dart';
import 'package:batch_student_starter/repository/student_repo.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../model/batch.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<Batch> _lstBatches = [];
  List<Course> _lstCourses = [];
  final List<Student> _lststudents = [];
  String _dropDownValue = "";

  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'Nirajan');
  final _lnameController = TextEditingController(text: 'Gautam');
  final _usernameController = TextEditingController(text: 'NirajanG');
  final _passwordController = TextEditingController(text: 'Nirajan123');

  @override
  void initState() {
    getbatch();
    getcourse();
    super.initState();
  }

  getbatch() async {
    _lstBatches = await BatchDataSource().getBatch();
  }

  getcourse() async {
    _lstCourses = await CourseDatasource().getAllCourse();
  }

  _saveStudent() async {
    Student students = Student(
      _fnameController.text,
      _lnameController.text,
      _usernameController.text,
      _passwordController.text,
    );

    final batch = _lstBatches
        .firstWhere((element) => element.batchName == _dropDownValue);

    for (Course c in _lstCourses) {
      students.course.add(c);
    }

    students.batch.target = batch;

    int status = await StudentRepositoryImpl().addStudent(students);
    _showmessage(status);
  }

  _showmessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text("student added successfully"),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text("Error Adding Student"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    controller: _fnameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lnameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FutureBuilder(
                    future: BatchDataSource().getBatch(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select batch';
                            }
                            return null;
                          },
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Select Batch',
                          ),
                          items: _lstBatches
                              .map((batch) => DropdownMenuItem(
                                    value: batch.batchName,
                                    child: Text(batch.batchName),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _dropDownValue = value!;
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FutureBuilder(
                    future: CourseRepositoryImpl().getAllCourse(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return MultiSelectDialogField(
                          title: const Text("Slect coursea"),
                          items: snapshot.data!
                              .map((course) =>
                                  MultiSelectItem(course, course.courseName))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          buttonText: const Text("select course"),
                          buttonIcon: const Icon(Icons.search),
                          onConfirm: (value) {
                            _lstCourses = value;
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _saveStudent();
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Brand Bold",
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
    );
  }
}
