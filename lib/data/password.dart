import 'package:hive/hive.dart';

part 'password.g.dart';

@HiveType(typeId: 0)
class Password extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String group;
  @HiveField(2)
  String password;
  @HiveField(3, defaultValue: false)
  bool hint;
  
  Password(this.name, this.group, this.password, {this.hint = false});
}