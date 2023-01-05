import 'package:batch_student_starter/helper/objectbox.dart';
import 'package:batch_student_starter/helper/objectbox.dart';
import 'package:batch_student_starter/model/batch.dart';
import 'package:batch_student_starter/model/student.dart';
import 'package:batch_student_starter/state/objectbox_state.dart';

class StudentDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addStudent(Student student) async {
  try {
    int result = await objectBoxInstance.addStudent(student);
    return result;
  } catch (e) {
    return Future.value(0);
  }
}

 
  Future<List<Student>> getStudents() async {
    try {
      var students = await objectBoxInstance.getAllStudent();
      return Future.value(students);
    } catch (e) {
      throw Exception('Error in getting all students: $e');
    }
  }

    Future<Student> loginStudent(String username, String password) {
    try {
      return Future.value(objectBoxInstance.loginstudent(username, password));
    } catch (e) {
      return Future.value(null);
    }
  }
}
