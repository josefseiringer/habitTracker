import 'dart:convert';

class HabitModel {
  final String? szNotionPageId;
  final String? szHabitId;
  final String? szHabitUser;
  final String? szType;
  final String? szTimeLengthMinute;
  final String? szDateOfHabit;
  final int? mnHideHabit;

  HabitModel({
    this.szNotionPageId,
    this.szHabitId,
    this.szHabitUser,
    this.szType,
    this.szTimeLengthMinute,
    this.szDateOfHabit,
    this.mnHideHabit
  });  

  HabitModel copyWith({
    String? szNotionPageId,
    String? szHabitId,
    String? szHabitUser,
    String? szType,
    String? szTimeLengthMinute,
    String? szDateOfHabit,
    int? mnHideHabit,
  }) {
    return HabitModel(
      szNotionPageId: szNotionPageId ?? this.szNotionPageId,
      szHabitId: szHabitId ?? this.szHabitId,
      szHabitUser: szHabitUser ?? this.szHabitUser,
      szType: szType ?? this.szType,
      szTimeLengthMinute: szTimeLengthMinute ?? this.szTimeLengthMinute,
      szDateOfHabit: szDateOfHabit ?? this.szDateOfHabit,
      mnHideHabit: mnHideHabit ?? this.mnHideHabit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': szNotionPageId,
      'HabitId': szHabitId,
      'HabitUser': szHabitUser,
      'HabitTyp': szType,
      'TimeLengthMinute': szTimeLengthMinute,
      'HabitDate': szDateOfHabit,
      'HideHabit': mnHideHabit,
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    final idPage = map['id'].toString();
    final properties = map['properties'] as Map<String, dynamic>;
    final nameListHabitId = (properties['HabitId']?['title'] ?? []) as List;
    final nameListHabitUser = (properties['HabitUser']?['rich_text'] ?? []) as List;
    final nameListHabitTyp = (properties['HabitTyp']?['rich_text'] ?? []) as List;
    final nameListTimeLengthMinute = (properties['TimeLengthMinute']?['rich_text'] ?? []) as List;
    final nameListHabitDate = (properties['HabitDate']?['rich_text'] ?? []) as List;
    return HabitModel(
      szNotionPageId: idPage,
      szHabitId: nameListHabitId.isNotEmpty ? nameListHabitId[0]['plain_text']: '?',
      szHabitUser: nameListHabitUser.isNotEmpty ? nameListHabitUser[0]['plain_text']: '?',
      szType: nameListHabitTyp.isNotEmpty ? nameListHabitTyp[0]['plain_text']: '?',
      szTimeLengthMinute: nameListTimeLengthMinute.isNotEmpty ? nameListTimeLengthMinute[0]['plain_text']: '?',
      szDateOfHabit: nameListHabitDate.isNotEmpty ? nameListHabitDate[0]['plain_text']: '?',
      mnHideHabit: (properties['HideHabit'] ? ['number'] ?? 0).toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HabitModel.fromJson(String source) => HabitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HabitModel(szNotionPageId: $szNotionPageId, szHabitId: $szHabitId, szHabitUser: $szHabitUser, szType: $szType, szTimeLengthMinute: $szTimeLengthMinute, szDateOfHabit: $szDateOfHabit, mnHideHabit: $mnHideHabit)';
  }
}
