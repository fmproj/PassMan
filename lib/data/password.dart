import 'package:hive/hive.dart';

part 'password.g.dart';

@HiveType(typeId: 0)
class Password extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? group;
  @HiveField(3)
  String? password;
  @HiveField(4, defaultValue: false)
  bool? hint;
  
  Password({this.id, this.name, this.group, this.password, this.hint});
}