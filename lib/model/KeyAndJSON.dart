import 'package:Weather_App/model/AJModel.dart';

class KeyAndJSON implements AJModel {
  int secondsSinceEpoch;
  String JSONObject;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return {
      'secondsSinceEpoch': secondsSinceEpoch,
      'JSONObject': JSONObject
    };
  }

  @override
  String data() {
    // TODO: implement data
    return JSONObject;
  }

  @override
  int primaryKeyValue() {
    // TODO: implement primaryKey
    return secondsSinceEpoch;
  }

  @override
  String primaryKeyName() {
    // TODO: implement primaryKeyName
    return "secondsSinceEpoch";
  }
}