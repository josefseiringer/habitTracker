import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/habit_model.dart';

class OverviewService {
  var dataList = <HabitModel>[];


  Future<List<HabitModel>> get habitList async {
    await _getGetHabits();
    return dataList;
  }

  Future<bool> _getGetHabits() async {
    var isOk = false;
    try {
      if (dataList.isNotEmpty) {
        dataList.clear();
      }
      final response =
          await http.post(Uri.parse(dotenv.env['URLLISTHABIT'].toString()), headers: khttpHeader);
      if (response.statusCode == 200) {
        //data to Model
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data.isNotEmpty) {
          //morphing data to model
          dataList = (data['results'] as List)
              .map((e) => HabitModel.fromMap(e))
              .toList();
          isOk = true;
        } else {
          isOk = false;
          //print('data is empty');
        }
      } else {
        isOk = false;
        //print('${response.statusCode}');
      }
    } catch (e) {
      isOk = false;
      //print('${e}Error Http Request');
    }
    return isOk;
  }

  Future<bool> saveHabitData(HabitModel habitDataItem) async {
    //Save Habit Data to Notion
    var isSaved = false;
    try {
      var saveUrl = 'https://api.notion.com/v1/pages/';
      var currentHabit = json.encode(currentBodyItem(habitDataItem));
      var response = await http.post(Uri.parse(saveUrl),
          headers: khttpHeader, body: currentHabit);
      if (response.statusCode == 200) {
        isSaved = true;
      } else {
        isSaved = false;
      }
    } catch (e) {
      isSaved = false;
    }
    return isSaved;
  }

  Future<bool> deletHabitItem(String szHabitPageId) async {
    var isTrue = false;
    try {
      var updateUrl = 'https://api.notion.com/v1/pages/$szHabitPageId';
      //delete in Notion
      final response = await http.patch(Uri.parse(updateUrl),
          headers: khttpHeader, body: json.encode(kDeleteUpdateMap));
      if (response.statusCode == 200) {
        isTrue = true;
      } else {
        isTrue = false;
      }
    } catch (e) {
      //print(e);
      isTrue = false;
    }
    return isTrue;
  }

  Future<bool> updateHabitData(HabitModel updateHabit) async {
    var isTrue = false;
    try {
      var mapUpdateItem = currentUpdateMap(updateHabit);
      var updateUrl =
          'https://api.notion.com/v1/pages/${updateHabit.szNotionPageId}';
      //delete in Notion
      final response = await http.patch(Uri.parse(updateUrl),
          headers: khttpHeader, body: json.encode(mapUpdateItem));
      if (response.statusCode == 200) {
        isTrue = true;
      } else {
        isTrue = false;
      }
    } catch (e) {
      //print(e);
      isTrue = false;
    }
    return isTrue;
  }

  Map<String, dynamic> currentUpdateMap(HabitModel habit) {
    return {
      'properties': {
        'HabitId': {
          'title': [
            {
              'text': {
                'content': habit.szHabitId,
              }
            }
          ]
        },
        'HabitUser': {
          'rich_text': [
            {
              'text': {
                'content': habit.szHabitUser,
              }
            }
          ]
        },
        'HabitTyp': {
          'rich_text': [
            {
              'text': {
                'content': habit.szType,
              }
            }
          ]
        },
        'TimeLengthMinute': {
          'rich_text': [
            {
              'text': {
                'content': habit.szTimeLengthMinute,
              }
            }
          ]
        },
        'HabitDate': {
          'rich_text': [
            {
              'text': {
                'content': habit.szDateOfHabit,
              }
            }
          ]
        },
        'HideHabit': {
          'number': habit.mnHideHabit,
        }
      }
    };
  }

  Map<String, dynamic> currentBodyItem(HabitModel model) {
    return {
      'parent': {
        'database_id': dotenv.env['DBHABITID'].toString(),
      },
      'properties': {
        'HabitId': {
          'title': [
            {
              'text': {
                'content': model.szHabitId,
              }
            }
          ]
        },
        'HabitUser': {
          'rich_text': [
            {
              'text': {
                'content': model.szHabitUser,
              }
            }
          ]
        },
        'HabitTyp': {
          'rich_text': [
            {
              'text': {
                'content': model.szType,
              }
            }
          ]
        },
        'TimeLengthMinute': {
          'rich_text': [
            {
              'text': {
                'content': model.szTimeLengthMinute,
              }
            }
          ]
        },
        'HabitDate': {
          'rich_text': [
            {
              'text': {
                'content': model.szDateOfHabit,
              }
            }
          ]
        },
        'HideHabit': {
          'number': model.mnHideHabit,
        }
      }
    };
  }
}
