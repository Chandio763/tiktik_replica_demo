class PostModel {
  final String id;
  final String title;
  final String videoUrl;
  final List<String> likedBy;

  PostModel({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.likedBy,
  });

  factory PostModel.fromFirestore(Map<String, dynamic> data, String id) {
    return PostModel(
      id: id,
      title: data['title'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      likedBy: List<String>.from(data['likedBy'] ?? []),
    );
  }
}
