import 'package:batch_student_starter/model/batch.dart';
import 'package:batch_student_starter/model/courses.dart';
import 'package:batch_student_starter/model/student.dart';
import 'package:batch_student_starter/objectbox.g.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

// improved code
@JsonSerializable()
class ObjectBoxInstance {
  late final Store _store;
  late final Box<Batch> _batch;
  late final Box<Student> _student;
  late final Box<Course> _Course;

  //constructer
  ObjectBoxInstance(this._store) {
    _batch = Box<Batch>(_store);
    _student = Box<Student>(_store);
    _Course = Box<Course>(_store);
    insertBatches();
    insertCourses();
  }

  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/student_course',
    );
    return ObjectBoxInstance(store);
  }

//---------------Batch Quries--------------
  int addBatch(Batch batch) {
    return _batch.put(batch);
  }

  List<Batch> getAllBatch() {
    return _batch.getAll();
  }

  int addCourse(Course course) {
    return _Course.put(course);
  }

  List<Course> getAllCourse() {
    return _Course.getAll();
  }

  // when app is opened for the firsttime insert some batches in the database

  void insertCourses() {
    List<Course> lstCourse = getAllCourse();
    if (lstCourse.isEmpty) {
      addCourse(Course('A'));
      addCourse(Course('Ba'));
      addCourse(Course('Aa'));
      addCourse(Course('Bd'));
    }
  }
  //---------------Student Quries--------------

  int addStudent(Student student) {
    return _student.put(student);
  }

  List<Student> getAllStudent() {
    return _student.getAll();
  }

  // when app is opened for the firsttime insert some batches in the database

  void insertBatches() {
    List<Batch> lstBatches = getAllBatch();
    if (lstBatches.isEmpty) {
      addBatch(Batch('29-A'));
      addBatch(Batch('29-B'));
      addBatch(Batch('28-A'));
      addBatch(Batch('28-B'));
    }
  }

  Future<bool> loginUser(String username, String password) async {
    var userData = _student
        .query(Student_.username.equals(username) &
            Student_.password.equals(password))
        .build()
        .findFirst();
    print("Data from Objectbox: $userData");
    print("Username from Objectbox: $username");

    return userData != null ? true : false;
  }
}



//initialization of objectBox

// login query