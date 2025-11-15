/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ModelUserList extends Equatable{
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<User>? userList;
  final Support? support;
  final Meta? meta;

  const ModelUserList({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.userList,
    this.support,
    this.meta,
  });

  ModelUserList copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
    List<User>? data,
    Support? support,
    Meta? meta,
  }) =>
      ModelUserList(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        totalPages: totalPages ?? this.totalPages,
        userList: data ?? userList,
        support: support ?? this.support,
        meta: meta ?? this.meta,
      );

  factory ModelUserList.fromRawJson(String str) => ModelUserList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelUserList.fromJson(Map<String, dynamic> json) => ModelUserList(
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    userList: json["data"] == null ? [] : List<User>.from(json["data"]!.map((x) => User.fromJson(x))),
    support: json["support"] == null ? null : Support.fromJson(json["support"]),
    meta: json["_meta"] == null ? null : Meta.fromJson(json["_meta"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x.toJson())),
    "support": support?.toJson(),
    "_meta": meta?.toJson(),
  };

  @override
  List<Object?> get props => [userList];
}

class User extends Equatable{
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  const User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  User copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}

class Meta {
  final String? poweredBy;
  final String? upgradeUrl;
  final String? docsUrl;
  final String? templateGallery;
  final String? message;
  final List<String>? features;
  final String? upgradeCta;

  Meta({
    this.poweredBy,
    this.upgradeUrl,
    this.docsUrl,
    this.templateGallery,
    this.message,
    this.features,
    this.upgradeCta,
  });

  Meta copyWith({
    String? poweredBy,
    String? upgradeUrl,
    String? docsUrl,
    String? templateGallery,
    String? message,
    List<String>? features,
    String? upgradeCta,
  }) =>
      Meta(
        poweredBy: poweredBy ?? this.poweredBy,
        upgradeUrl: upgradeUrl ?? this.upgradeUrl,
        docsUrl: docsUrl ?? this.docsUrl,
        templateGallery: templateGallery ?? this.templateGallery,
        message: message ?? this.message,
        features: features ?? this.features,
        upgradeCta: upgradeCta ?? this.upgradeCta,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    poweredBy: json["powered_by"],
    upgradeUrl: json["upgrade_url"],
    docsUrl: json["docs_url"],
    templateGallery: json["template_gallery"],
    message: json["message"],
    features: json["features"] == null ? [] : List<String>.from(json["features"]!.map((x) => x)),
    upgradeCta: json["upgrade_cta"],
  );

  Map<String, dynamic> toJson() => {
    "powered_by": poweredBy,
    "upgrade_url": upgradeUrl,
    "docs_url": docsUrl,
    "template_gallery": templateGallery,
    "message": message,
    "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
    "upgrade_cta": upgradeCta,
  };
}

class Support {
  final String? url;
  final String? text;

  Support({
    this.url,
    this.text,
  });

  Support copyWith({
    String? url,
    String? text,
  }) =>
      Support(
        url: url ?? this.url,
        text: text ?? this.text,
      );

  factory Support.fromRawJson(String str) => Support.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}
