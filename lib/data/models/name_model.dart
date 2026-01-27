import 'package:amk_bank_project/domain/entities/name_entity.dart';

class NameModel extends NameEntity {
  NameModel({required super.id, required super.name});

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      NameModel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
