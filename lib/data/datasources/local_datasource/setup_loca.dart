import 'package:projecttas_223200007/data/datasources/local_datasource/db_localdatasource.dart';

class SetupLocalDataSource {
  static Future<void> initialize() async {
    await DBLocalDatasource.init();
  }
}
