class VideoModel {
  String? chapter;
  String? lecturer;
  String? name;
  String? videoId;

  VideoModel({this.chapter, this.lecturer, this.name, this.videoId});

  VideoModel.fromJson(Map<String, dynamic> json) {
    chapter = json['chapter'];
    lecturer = json['lecturer'];
    name = json['name'];
    videoId = json['video_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter'] = this.chapter;
    data['lecturer'] = this.lecturer;
    data['name'] = this.name;
    data['video_id'] = this.videoId;
    return data;
  }
}
