class VideoModel {
  final int id;
  final int zzal;
  final String video;

  VideoModel({required this.id, required this.zzal, required this.video});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as int,
      zzal: json['zzal'] as int,
      video: json['video'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'zzal': zzal, 'video': video};
  }
}

class ZzalModel {
  final int id;
  final String username;
  final String name;
  final String description;
  final VideoModel video;
  final DateTime createdAt;

  ZzalModel({
    required this.id,
    required this.username,
    required this.name,
    required this.description,
    required this.video,
    required this.createdAt,
  });

  factory ZzalModel.fromJson(Map<String, dynamic> json) {
    return ZzalModel(
      id: json['id'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      video: VideoModel.fromJson(json['video']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'description': description,
      'video': video.toJson(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
