import 'package:batch_student_starter/model/batch.dart';
import 'package:batch_student_starter/model/courses.dart';
import 'package:objectbox/objectbox.dart';

//entity = table
@Entity()
class Student {
  @Id(assignable: true) //auto increment
  int stdId;
  String fname;
  String lname;
  String username;
  String password;

  final batch = ToOne<Batch>();
  final course = ToMany<Course>();

  Student(this.fname, this.lname, this.username, this.password,
      {this.stdId = 0}); //student constructer

}

// flutter pub run build_runner build --delete-conflicting-outputs