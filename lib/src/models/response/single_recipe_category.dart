import '../data/recipe_category_data.dart';

class SingleRecipeCategory {
  SingleRecipeCategory({
    String? timestamp,
    bool? status,
    String? message,
    RecipeCategoryData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  SingleRecipeCategory.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? RecipeCategoryData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  RecipeCategoryData? _data;

  SingleRecipeCategory copyWith({
    String? timestamp,
    bool? status,
    String? message,
    RecipeCategoryData? data,
  }) =>
      SingleRecipeCategory(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  RecipeCategoryData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
