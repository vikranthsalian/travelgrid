class MetaTravelModeListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaTravelModeListResponse({this.status, this.token, this.message, this.data});

  MetaTravelModeListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] == "SUCCESS" ? true:false;
    token = json['token'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class Data {
  int? id;
  String? value;
  bool? disabled;
  bool? deleted;
  I18nTextName? i18nTextName;
  String? label;

  Data({this.id, this.value, this.disabled, this.deleted, this.i18nTextName, this.label});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    disabled = json['disabled'];
    deleted = json['deleted'];
    i18nTextName = json['i18nTextName'] != null ? new I18nTextName.fromJson(json['i18nTextName']) : null;
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['disabled'] = this.disabled;
    data['deleted'] = this.deleted;
    if (this.i18nTextName != null) {
      data['i18nTextName'] = this.i18nTextName!.toJson();
    }
    data['label'] = this.label;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'value': this.value,
      'disabled': this.disabled,
      'deleted': this.deleted,
      'i18nTextName': this.i18nTextName,
      'label': this.label,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] as int,
      value: map['value'] as String,
      disabled: map['disabled'] as bool,
      deleted: map['deleted'] as bool,
      i18nTextName: map['i18nTextName'] as I18nTextName,
      label: map['label'] as String,
    );
  }
}

class I18nTextName {
  //I18nText? i18nText;
  String? defaultText;
  String? text;

  I18nTextName({
   // this.i18nText,
    this.defaultText,
    this.text});

  I18nTextName.fromJson(Map<String, dynamic> json) {
   // i18nText = json['i18nText'] != null ? new I18nText.fromJson(json['i18nText']) : null;
    defaultText = json['defaultText'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.i18nText != null) {
    //   data['i18nText'] = this.i18nText!.toJson();
    // }
    data['defaultText'] = this.defaultText;
    data['text'] = this.text;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'defaultText': this.defaultText,
      'text': this.text,
    };
  }

  factory I18nTextName.fromMap(Map<String, dynamic> map) {
    return I18nTextName(
      defaultText: map['defaultText'] as String,
      text: map['text'] as String,
    );
  }
}

// class I18nText {
//
//
//   I18nText({});
//
// I18nText.fromJson(Map<String, dynamic> json) {
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   return data;
// }
// }
