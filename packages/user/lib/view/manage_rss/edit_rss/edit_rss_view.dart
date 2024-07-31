import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rss_api/model/rss_feed.dart';
import 'package:uikit/uikit.dart';
import 'package:user/bloc/manage_rss/edit_rss/edit_rss_bloc.dart';

class EditRssView extends StatefulWidget {
  final RssFeed rssFeed;

  const EditRssView({super.key, required this.rssFeed});

  static void show(BuildContext context, RssFeed rssFeed) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  EditRssBloc(repository: GetIt.I.get(), rssFeed: rssFeed),
            )
          ],
          child: BlocListener<EditRssBloc, EditRssState>(
            listener: (context, state) {
              if (state is EditRssSuccess) {
                Navigator.pop(context);
              } else if (state is EditRssFailed) {
                UIToast.showToast(
                  context: context,
                  message: state.error,
                  type: ToastType.error,
                );
              }
            },
            child: EditRssView(
              rssFeed: rssFeed,
            ),
          ),
        );
      },
    );
  }

  @override
  State<EditRssView> createState() => _EditRssViewState();
}

class _EditRssViewState extends State<EditRssView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _rssUrlTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameTextController.text = widget.rssFeed.name;
    _rssUrlTextController.text = widget.rssFeed.url;
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _rssUrlTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edit RSS Feed",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color.title,
              ),
            ),
            Text(
              "Never miss an update. Stay in the know with RSS feeds",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: color.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  UIKitTextField(
                    title: "Title (Optional)",
                    placeholder: "Enter RSS Title",
                    controller: _nameTextController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  UIKitTextField(
                    title: "RSS URL",
                    placeholder: "Enter RSS URL",
                    controller: _rssUrlTextController,
                    rules: const [
                      ValidationRule.required,
                      ValidationRule.url,
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<EditRssBloc, EditRssState>(
              builder: (context, state) {
                return UIKitButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<EditRssBloc>().add(
                            EditRssRequested(
                              name: _nameTextController.text.isEmpty
                                  ? null
                                  : _nameTextController.text,
                              url: _rssUrlTextController.text,
                            ),
                          );
                    }
                  },
                  text: "Edit an RSS",
                  isLoading: state is EditRssLoading,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
