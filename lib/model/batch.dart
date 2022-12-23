//flutter pub run build_runner build  --delete-conflicting-outputs

import 'package:batch_student_starter/model/student.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Batch {
  @Id(assignable: true)
  int batchId;
  String batchName;

  //tomany bhako thau ma bank link use garne
  @Backlink()
  final student = ToMany<Student>();

  
  Batch(this.batchName, {this.batchId = 0});
  
  
}


// flutter pub run build_runner build --delete-conflicting-outputs
