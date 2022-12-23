import 'package:batch_student_starter/helper/objectbox.dart';
import 'package:batch_student_starter/helper/objectbox.dart';
import 'package:batch_student_starter/model/student.dart';
import 'package:batch_student_starter/state/objectbox_state.dart';


class StuentDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addStudent(Student student) async {
    try {
      return objectBoxInstance.addStudent(student);
    } catch (e) {
      return Future.value(0);
    }
  }
}
