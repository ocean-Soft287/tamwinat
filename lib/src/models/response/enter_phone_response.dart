class EnterPhoneResponse {
  EnterPhoneResponse({
    String? timestamp,
    bool? status,
    String? message,
    EnterPhoneData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  EnterPhoneResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? EnterPhoneData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  EnterPhoneData? _data;

  EnterPhoneResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    EnterPhoneData? data,
  }) =>
      EnterPhoneResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  EnterPhoneData? get data => _data;

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

class EnterPhoneData {
  EnterPhoneData({String? verifyId, String? phone}) {
    _verifyId = verifyId;
    _phone = phone;
  }

  EnterPhoneData.fromJson(dynamic json) {
    _verifyId = json['verifyId'];
    _phone = json['phone'];
  }

  String? _verifyId;
  String? _phone;

  EnterPhoneData copyWith({String? verifyId, String? phone}) =>
      EnterPhoneData(verifyId: verifyId ?? _verifyId, phone: phone ?? _phone);

  String? get verifyId => _verifyId;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['verifyId'] = _verifyId;
    map['phone'] = _phone;
    return map;
  }
}
