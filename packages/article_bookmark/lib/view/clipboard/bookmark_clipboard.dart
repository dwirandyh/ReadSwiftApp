import 'package:article_bookmark/article_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';

class BookmarkClipboard extends StatefulWidget {
  final VoidCallback onClosePressed;
  const BookmarkClipboard({super.key, required this.onClosePressed});

  @override
  State<BookmarkClipboard> createState() => _BookmarkClipboardState();

  static void show(
      {required BuildContext context, required BookmarkClipboardBloc bloc}) {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: 16,
        child: BlocProvider<BookmarkClipboardBloc>.value(
          value: bloc,
          child: BookmarkClipboard(
            onClosePressed: () {
              bloc.add(BookmarkClipboardCloseRequested());
              overlayEntry?.remove();
            },
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }
}

class _BookmarkClipboardState extends State<BookmarkClipboard> {
  Widget saveButton(String url, bool isBeingSubmitted) {
    if (isBeingSubmitted) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: () {
          context
              .read<BookmarkClipboardBloc>()
              .add(BookmarkClipboardSaveRequested(link: url));
        },
        child: const Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: color.accent,
      child: BlocBuilder<BookmarkClipboardBloc, BookmarkClipboardState>(
        builder: (context, state) {
          if (state is BookmarkClipboardLinkUpdated) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 32,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: widget.onClosePressed,
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Save copied URL?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.url,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    saveButton(state.url, state.isBeingSubmitted),
                  ],
                ),
              ),
            );
          } else if (state is BookmarkClipboardSaved) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 32,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: widget.onClosePressed,
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                    ),
                    const Text(
                      "Link saved",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is BookmarkClipboardFailed) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 32,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: widget.onClosePressed,
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                    ),
                    const Text(
                      "Failed to save article, please try again later",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Placeholder();
          }
        },
      ),
    );
  }
}
