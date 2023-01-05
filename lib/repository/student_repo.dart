import 'package:batch_student_starter/data_source/local_data_source.dart/student_data_source.dart';
import 'package:batch_student_starter/model/student.dart';

abstract class StudentRepositry {
  Future<List<Student>> getStudent();
  Future<int> addStudent(Student student);
  Future<bool?> loginstudent(String username, String password);
}

class StudentRepositoryImpl extends StudentRepositry {
  @override
  Future<int> addStudent(Student student) async {
    return await StudentDataSource().addStudent(student);
  }

  @override
  Future<List<Student>> getStudent() async {
    List<Student> studentList = await StudentDataSource().getStudents();
    return studentList;
  }
  @override
   Future<bool> loginstudent(String username, String password) {
    return StudentDataSource().loginStudent(username, password).then((result) {
      return result;
    });
  }
}
