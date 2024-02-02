import 'package:intl/intl.dart';

class WebContent {
  final String title;
  final String? author;
  final DateTime? datePublished;
  final String? content;
  final String domain;

  WebContent({
    required this.title,
    this.author,
    this.datePublished,
    this.content,
    required this.domain,
  });

  String? formattedPublishedDate() {
    if (datePublished != null) {
      return DateFormat.MMMd().format(datePublished!);
    }
    return null;
  }

  String? fullFormattedPublishedDate() {
    if (datePublished != null) {
      return DateFormat("MMMM d, y hh:mm a").format(datePublished!);
    }
    return null;
  }
}
