import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class RssContent extends Equatable {
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

  const RssContent({
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

  RssContent copyWith({
    int? id,
    String? title,
    String? author,
    DateTime? datePublished,
    String? leadImage,
    String? content,
    String? url,
    String? domain,
    String? excerpt,
    int? wordCount,
  }) {
    return RssContent(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      datePublished: datePublished ?? this.datePublished,
      leadImage: leadImage ?? this.leadImage,
      content: content ?? this.content,
      url: url ?? this.url,
      domain: domain ?? this.domain,
      excerpt: excerpt ?? this.excerpt,
      wordCount: wordCount ?? this.wordCount,
    );
  }

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

  String? estimatedReadingTime() {
    if (wordCount != null) {
      int minutes = (wordCount! / 200).ceil();
      return "$minutes min read";
    }
    return null;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        author,
        datePublished,
        leadImage,
        content,
        url,
        domain,
        excerpt,
        wordCount,
      ];
}
