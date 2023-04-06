import 'models/habit_model.dart';

var kMoLocalHabitList = [
  HabitModel(
      szHabitId: DateTime.now().microsecondsSinceEpoch.toString(),
      szHabitUser: 'Franz',
      szDateOfHabit: '2023-03-27',
      szTimeLengthMinute: '55',
      szType: 'Gehen'),
  HabitModel(
      szHabitId: DateTime.now().microsecondsSinceEpoch.toString(),
      szHabitUser: 'Josef',
      szDateOfHabit: '2023-03-24',
      szTimeLengthMinute: '120',
      szType: 'Gartenarbeit'),
  HabitModel(
      szHabitId: DateTime.now().microsecondsSinceEpoch.toString(),
      szHabitUser: 'Franz',
      szDateOfHabit: '2023-05-24',
      szTimeLengthMinute: '30',
      szType: 'Gartenarbeit'),
  HabitModel(
      szHabitId: DateTime.now().microsecondsSinceEpoch.toString(),
      szHabitUser: 'Josef',
      szDateOfHabit: '2023-03-27',
      szTimeLengthMinute: '55',
      szType: 'Gehen'),
];

var kMoUserName = '';
