import 'package:askforastro/util/utils.dart';

class AgentsListModel {
  AgentsListModel({
    required this.httpStatus,
    required this.httpStatusCode,
    required this.success,
    required this.message,
    required this.apiName,
    required this.data,
  });

  late final String httpStatus;
  late final int httpStatusCode;
  late final bool success;
  late final String message;
  late final String apiName;
  late final List<AgentData> data;

  AgentsListModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    data = List.from(json['data']).map((e) => AgentData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['httpStatus'] = httpStatus;
    _data['httpStatusCode'] = httpStatusCode;
    _data['success'] = success;
    _data['message'] = message;
    _data['apiName'] = apiName;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AgentData {
  AgentData(
      {required this.id,
      required this.urlSlug,
      this.namePrefix,
      required this.firstName,
      required this.lastName,
      required this.aboutMe,
      this.profliePicUrl,
      required this.experience,
      required this.languages,
      required this.minimumCallDuration,
      required this.minimumCallDurationCharges,
      required this.additionalPerMinuteCharges,
      required this.isAvailable,
      this.rating,
      required this.skills,
      required this.isOnCall,
      required this.freeMinutes,
      required this.additionalMinute,
      required this.images,
      required this.filterSkilled,
      required this.filterLanguage});

  late final int id;
  late final String urlSlug;
  late final dynamic namePrefix;
  late final String firstName;
  late final String lastName;
  late final dynamic aboutMe;
  late final dynamic profliePicUrl;
  late final double experience;
  late final List<Skills> languages;
  late final dynamic minimumCallDuration;
  late final dynamic minimumCallDurationCharges;
  late final dynamic additionalPerMinuteCharges;
  late final bool isAvailable;
  late final dynamic rating;
  late final List<Skills> skills;
  late final String filterSkilled;
  late final String filterLanguage;
  late final bool isOnCall;
  late final dynamic freeMinutes;
  late final dynamic additionalMinute;
  late final Images images;

  AgentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urlSlug = json['urlSlug'];
    namePrefix = json['namePrefix'];
    firstName = '${namePrefix ?? ''} ' + json['firstName'];
    lastName = json['lastName'];
    aboutMe = json['aboutMe'];
    profliePicUrl = json['profliePicUrl'];
    experience = json['experience'];
    languages = json['languages'] != null
        ? List.from(json['languages']).map((e) => Skills.fromJson(e)).toList()
        : [];
    minimumCallDuration = json['minimumCallDuration'];
    minimumCallDurationCharges = json['minimumCallDurationCharges'];
    additionalPerMinuteCharges = json['additionalPerMinuteCharges'];
    isAvailable = json['isAvailable'];
    rating = json['rating'];
    skills = json['skills'] != null
        ? List.from(json['skills']).map((e) => Skills.fromJson(e)).toList()
        : [];
    isOnCall = json['isOnCall'];
    freeMinutes = json['freeMinutes'];
    additionalMinute = json['additionalMinute'];
    images = Images.fromJson(json['images']);
    filterSkilled = skills.isNotEmpty ? getSkilledName(skills) : '';
    filterLanguage = languages.isNotEmpty ? getSkilledName(languages) : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['urlSlug'] = urlSlug;
    _data['namePrefix'] = namePrefix;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['aboutMe'] = aboutMe;
    _data['profliePicUrl'] = profliePicUrl;
    _data['experience'] = experience;
    _data['languages'] = languages.map((e) => e.toJson()).toList();
    _data['minimumCallDuration'] = minimumCallDuration;
    _data['minimumCallDurationCharges'] = minimumCallDurationCharges;
    _data['additionalPerMinuteCharges'] = additionalPerMinuteCharges;
    _data['isAvailable'] = isAvailable;
    _data['rating'] = rating;
    _data['skills'] = skills.map((e) => e.toJson()).toList();
    _data['isOnCall'] = isOnCall;
    _data['freeMinutes'] = freeMinutes;
    _data['additionalMinute'] = additionalMinute;
    _data['images'] = images.toJson();
    _data['filterSkilled'] = filterSkilled;
    return _data;
  }
}

// class Languages {
//   Languages({
//     required this.id,
//     required this.name,
//     this.isSelected = false
//   });
//
//   late final int id;
//   late final String name;
//   late final bool isSelected;
//
//   Languages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     isSelected = json['isSelected'] ?? false;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['isSelected'] = isSelected;
//     return _data;
//   }
// }

class Skills {
  Skills(
      {required this.id,
      required this.name,
      required this.description,
      this.isSelected = false});

  late final int id;
  late final String name;
  late final String description;
  late bool isSelected;

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'] ?? '';
    isSelected = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['isSelected'] = isSelected;
    return _data;
  }
}

class Images {
  Images({
    required this.small,
    required this.large,
    required this.medium,
  });

  late final Small small;
  late final Large large;
  late final Medium medium;

  Images.fromJson(Map<String, dynamic> json) {
    small = Small.fromJson(json['small']);
    large = Large.fromJson(json['large']);
    medium = Medium.fromJson(json['medium']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['small'] = small.toJson();
    _data['large'] = large.toJson();
    _data['medium'] = medium.toJson();
    return _data;
  }
}

class Small {
  Small({
    this.imageUrl,
    this.id,
  });

  late final dynamic imageUrl;
  late final dynamic id;

  Small.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageUrl'] = imageUrl;
    _data['id'] = id;
    return _data;
  }
}

class Large {
  Large({
    required this.imageUrl,
    required this.id,
  });

  late final dynamic imageUrl;
  late final dynamic id;

  Large.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageUrl'] = imageUrl;
    _data['id'] = id;
    return _data;
  }
}

class Medium {
  Medium({
    required this.imageUrl,
    required this.id,
  });

  late final dynamic imageUrl;
  late final dynamic id;

  Medium.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageUrl'] = imageUrl;
    _data['id'] = id;
    return _data;
  }
}
