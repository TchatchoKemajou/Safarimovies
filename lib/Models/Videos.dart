class Videos{
  final String videoCreatorId;
  final String videoTitle;
  final String videoContent;
  final String videoImages;
  final String videoRubrique;
  final String videoDateOut;
  final double videoDuration;
  final String videoPub;
  final String videoBannier;
  final String videoAge;
  final String videoQuality;
  final String videoDescription;

  const Videos(
      {required this.videoCreatorId,
      required this.videoTitle,
      required this.videoContent,
      required this.videoImages,
      required this.videoRubrique,
      required this.videoDateOut,
      required this.videoDuration,
      required this.videoPub,
      required this.videoBannier,
      required this.videoAge,
      required this.videoQuality,
      required  this.videoDescription
      });

  factory Videos.fromjson(Map<String, dynamic> json) => Videos(
      videoCreatorId: json["creator_id"] != null ? "" : json["creator_id"],
      videoTitle: json["titre"] != null ? "" : json["titre"],
      videoContent: json["video"] != null ? "" : json["video"],
      videoImages: json["image"] != null ? "" : json["image"],
      videoRubrique: json["rubrique"] != null ? "" : json["rubrique"],
      videoDateOut: json["date_de_sortie"] != null ? "" : json["date_de_sortie"],
      videoDuration: json["duree"] != null ? "" : json["duree"],
      videoPub: json["pub"] != null ? "" : json["pub"],
      videoBannier: json["banniere"] != null ? "" : json["banniere"],
      videoAge: json["age"] != null ? "" : json["age"],
      videoQuality: json["qualite"] != null ? "" : json["qualite"],
      videoDescription: json["description"] != null ? "" : json["description"]);

  Map<String, dynamic> toMap() => {
    "creator_id" : videoCreatorId,
    "titre" : videoTitle,
    "video" : videoContent,
    "image" : videoImages,
    "rubrique" : videoRubrique,
    "date_de_sortie" : videoDateOut,
    "duree" : videoDuration,
    "pub" : videoPub,
    "banniere" : videoBannier,
    "age": videoAge,
    "qualite" : videoQuality,
    "description" : videoDescription
  };

}