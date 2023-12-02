import 'package:hive/hive.dart';
part 'categories.g.dart';

@HiveType(typeId: 1)
enum Categories {
  @HiveField(0)
  food,
  @HiveField(1)
  travel,
  @HiveField(2)
  entertainment,
  @HiveField(3)
  health,
  @HiveField(4)
  others
}

Categories fromString(String category) {
  switch (category) {
    case 'food':
      return Categories.food;
    case 'entertainment':
      return Categories.entertainment;
    case 'travel':
      return Categories.travel;
    case 'health':
      return Categories.health;
    case 'others':
      return Categories.others;
  }
  return Categories.others;
}

String toString(Categories categroy){
  switch (categroy) {
      case Categories.food:
        return 'food';
      case Categories.entertainment:
        return 'entertainment';
      case Categories.travel:
        return 'travel';
      case Categories.health:
        return 'health';
      case Categories.others:
        return 'others';
    }
}
