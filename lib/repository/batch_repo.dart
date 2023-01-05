import 'package:batch_student_starter/data_source/local_data_source.dart/batch_data_source.dart';
import 'package:batch_student_starter/model/batch.dart';

abstract class BatchRepositry {
  Future<List<Batch>> getBatch();
  Future<int> addBatch(Batch batch);
}

class BatchRepositoryImpl extends BatchRepositry {
  @override
  Future<int> addBatch(Batch batch) {
    return BatchDataSource().addBatch(batch);
  }

  @override
  Future<List<Batch>> getBatch() {
    return BatchDataSource().getBatch();
  }
}
