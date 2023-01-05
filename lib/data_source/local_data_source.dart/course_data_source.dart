import 'package:batch_student_starter/helper/objectbox.dart';
import 'package:batch_student_starter/model/courses.dart';
import 'package:batch_student_starter/state/objectbox_state.dart';

class CourseDatasource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  
  Future<int> addcourse(Course course) async {
    try {
      return objectBoxInstance.addCourse(course);
    } catch (e) {
      return Future.value(0);
    }
  }

   Future<List<Course>> getAllCourse() async {
    try {
      return Future.value(objectBoxInstance.getAllCourse());
    } catch (e) {
      throw Exception('error in getting all Course');
    }
  }


}
