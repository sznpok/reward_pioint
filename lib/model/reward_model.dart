import 'package:hive/hive.dart';

part 'reward_model.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String? phonNumber;

  @HiveField(1)
  final String? amount;

  @HiveField(2)
  final String? rewardPoint;

  Todo({this.phonNumber, this.amount, this.rewardPoint});
}
