class ArticleEntity {
  final int id;
  final String title;
  final String? author;
  final DateTime? datePublished;
  final String? leadImage;
  final String? content;
  final String url;
  final String domain;
  final String? excerpt;
  final int? wordCount;

  ArticleEntity({
    required this.id,
    required this.title,
    this.author,
    this.datePublished,
    this.leadImage,
    this.content,
    required this.url,
    required this.domain,
    this.excerpt,
    this.wordCount,
  });
}
