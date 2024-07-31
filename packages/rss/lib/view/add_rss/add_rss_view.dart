import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';
import 'package:rss/bloc/add_rss/add_rss_bloc.dart';
import 'package:rss/bloc/rss_feed/rss_feed_bloc.dart';
import 'package:rss/repository/rss_repository.dart';
import 'package:uikit/uikit.dart';

class AddRssView extends StatefulWidget {
  const AddRssView({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (bottomSheetContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AddRssBloc(
                rssRepository: RssRepositoryImpl(client: HttpNetwork.client),
              ),
            ),
            BlocProvider.value(
              value: BlocProvider.of<RssFeedBloc>(context),
            ),
          ],
          child: BlocListener<AddRssBloc, AddRssState>(
            listener: (context, state) {
              if (state is AddRssSuccess) {
                context.read<RssFeedBloc>().add(RssFeedFetched());

                Navigator.pop(context);
                UIToast.showToast(
                  context: context,
                  message: "You're all set! The RSS feed is now active.",
                );
              } else if (state is AddRssFailed) {
                UIToast.showToast(
                  context: context,
                  message: state.error,
                  type: ToastType.error,
                );
              }
            },
            child: const AddRssView(),
          ),
        );
      },
    );
  }

  @override
  State<AddRssView> createState() => _AddRssViewState();
}

class _AddRssViewState extends State<AddRssView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _rssUrlTextController = TextEditingController();

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
              "Add an New RSS Feed",
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
            BlocBuilder<AddRssBloc, AddRssState>(
              builder: (context, state) {
                return UIKitButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddRssBloc>().add(
                            AddRssRequested(
                              name: _nameTextController.text.isEmpty
                                  ? null
                                  : _nameTextController.text,
                              url: _rssUrlTextController.text,
                            ),
                          );
                    }
                  },
                  text: "Add an RSS",
                  isLoading: state is AddRssLoading,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
