class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String uid;
  final String creator;
  final String id;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.uid,
    required this.creator,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  VideoModel.fromJson(Map<String, dynamic> json, String videoId)
      : title = json["title"],
        description = json["description"],
        fileUrl = json["fileUrl"],
        thumbnailUrl = json["thumbnailUrl"],
        uid = json["uid"],
        creator = json["creator"],
        likes = json["likes"],
        comments = json["comments"],
        id = videoId,
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "uid": uid,
      "creator": creator,
      "likes": likes,
      "comments": comments,
      "createdAt": createdAt,
      "id": id,
    };
  }
}
