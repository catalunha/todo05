//file: lib/app/data/datasources/datasources.dart
enum DatasourcesEnum {
  hive,
  firebase,
  isar,
  couchbase,
  appwrite,
}

extension DatasourcesEnumDescription on DatasourcesEnum {
  String get description {
    switch (this) {
      case DatasourcesEnum.hive:
        return 'Local (com Hive)';
      case DatasourcesEnum.firebase:
        return 'Núvem (com Firebase)';
      case DatasourcesEnum.isar:
        return 'Local (com Isar)';
      case DatasourcesEnum.couchbase:
        return 'Núvem (com CouchBase)';
      case DatasourcesEnum.appwrite:
        return 'Núvem (com AppWrite)';
    }
  }
}
