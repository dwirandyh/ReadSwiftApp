import 'package:article_bookmark/bloc/article/add_article_tag/add_article_tag_bloc.dart';
import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:article_bookmark/repository/tag_repository.dart';
import 'package:article_bookmark/view/article/article_tag/add_article_tag_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foundation/foundation.dart';
import 'package:network/network.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  const ArticleItem._({
    super.key,
    required this.article,
  });

  static Widget create({required Article article}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddArticleTagBloc(
            article: article,
            tagRepository: TagRepositoryImpl(client: HttpNetwork.client),
            articleRepository: ArticleRepositoryImpl(
              client: HttpNetwork.client,
            ),
          ),
        ),
      ],
      child: BlocListener<AddArticleTagBloc, AddArticleTagState>(
        listener: (context, state) {
          if (state is AddArticleTagRemoved) {
            context.read<ArticleBloc>().add(
                ArticleTagRemoved(article: article, tag: state.removedTag));
          }
        },
        child: ArticleItem._(
          article: article,
        ),
      ),
    );
  }

  Widget _thumbnail(BuildContext context) {
    final String? leadImageURL = article.leadImage;
    if (leadImageURL == null) {
      return const SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: leadImageURL,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    }
  }

  Widget _thumbnailAction(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            iconSize: 24,
            padding: EdgeInsets.zero,
            onPressed: () {
              AddArticleTagView.show(
                context: context,
                article: article,
                articleTags: article.tags,
              );
            },
            icon: const Icon(Icons.playlist_add),
          ),
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            iconSize: 24,
            padding: EdgeInsets.zero,
            onPressed: () {
              ShareUtil.shareText(context,
                  "Check out this story i saved on ReadSwift \n${article.url}");
            },
            icon: const Icon(Icons.share),
          ),
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            iconSize: 24,
            padding: EdgeInsets.zero,
            onPressed: () {
              context.read<ArticleBloc>().add(ArticleDeleted(article: article));
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article.domain),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 70,
                        child: Text(
                          article.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _thumbnail(context)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    Text(
                      article.formattedPublishedDate() ?? "",
                      style: TextStyle(
                        color: color.caption,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "•",
                      style: TextStyle(
                        color: color.caption,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      article.estimatedReadingTime() ?? "",
                      style: TextStyle(
                        color: color.caption,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _thumbnailAction(context)
              ],
            ),
          ),
          Divider(
            color: color.caption,
          )
        ],
      ),
    );
  }
}
