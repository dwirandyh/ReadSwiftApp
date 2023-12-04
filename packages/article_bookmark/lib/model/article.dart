import 'package:intl/intl.dart';

class Article {
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

  Article({
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

  String? formattedPublishedDate() {
    if (datePublished != null) {
      return DateFormat.MMMd().format(datePublished!);
    }
    return null;
  }

  String? estimatedReadingTime() {
    if (wordCount != null) {
      int minutes = (wordCount! / 200).ceil();
      return "$minutes min read";
    }
    return null;
  }
}
