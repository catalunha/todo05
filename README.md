# todo05

# Estrutura
Leituras:
* https://medium.com/@mashoodsidd97/understanding-of-clean-architecture-in-your-flutter-apps-with-tdd-test-driven-development-e674429fa0d
* https://medium.com/@mashoodsidd97/clean-architecture-tdd-with-flutter-part-2-968c7fc52c5b
* 

Se o objetivo de uma abstração/interface é guiar as implementações ?
Esta abordagem a seguir esta correta ?
* view
* view-model
* model
  * models
    * taskModel.dart
  * repositories
    * task_repository_abstract.dart
    * firebase
      * task
        * task_repository_impl.dart
    * hive
      * task
        * task_repository_impl.dart

model/repositories/task_repository_abstract.dart
```Dart
abstract class TaskRepositoryAbstract {
  Future<void> create(TaskModel taskModel);
}
```
## Firebase
model/repositories/firebase/task_repository_impl.dart
```Dart
class TaskRepositoryImpl implements TaskRepositoryAbstract {
  @override
  Future<void> create(TaskModel taskModel){
    // create modo Firebase
  }
}
```
## Hive
model/repositories/hive/task_repository_impl.dart
```Dart
class TaskRepositoryImpl implements TaskRepositoryAbstract {
  @override
  Future<void> create(TaskModel taskModel){
    // create modo Hive
  }
}
```