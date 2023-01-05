import 'package:batch_student_starter/data_source/local_data_source.dart/batch_data_source.dart';
import 'package:batch_student_starter/model/batch.dart';
import 'package:batch_student_starter/model/courses.dart';

import '../data_source/local_data_source.dart/course_data_source.dart';

abstract class CourseRepositry {
  Future<int> addCourse(Course course);
  Future<List<Course>> getAllCourse();


}

class CourseRepositoryImpl extends CourseRepositry {
  @override
  Future<int> addCourse(Course course) {
     return CourseDatasource().addcourse(course);
  }

  @override
  Future<List<Course>> getAllCourse() {
     return CourseDatasource().getAllCourse();
  }

 
}
