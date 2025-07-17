import 'dart:convert';

import 'package:yes_no_app/domain/entities/message.dart';

YesNoModel yesNoModelFromJson(String str) => YesNoModel.fromJsonMap(json.decode(str));

String yesNoModelToJson(YesNoModel data) => json.encode(data.toJson());

class YesNoModel {
  String answer;
  bool forced;
  String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

    Message toMessageEntity()=> Message(
      text: answer == 'yes' ? 'Sí' : 'No',
      fromWho: FromWho.hers,
      imageUrl: image,
    );
}
