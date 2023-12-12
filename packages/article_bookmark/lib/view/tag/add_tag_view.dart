import 'package:article_bookmark/bloc/add_tag/add_tag_bloc.dart';
import 'package:article_bookmark/bloc/tag/tag_bloc.dart';
import 'package:article_bookmark/repository/tag_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:network/network.dart';
import 'package:uikit/uikit.dart';

class AddTagView extends StatefulWidget {
  const AddTagView({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<TagBloc>.value(
                value: BlocProvider.of<TagBloc>(context)),
            BlocProvider<AddTagBloc>(
              create: (context) => AddTagBloc(
                tagRepository: TagRepositoryImpl(client: HttpNetwork.client),
              ),
            )
          ],
          child: const AddTagView(),
        );
      },
    );
  }

  @override
  State<AddTagView> createState() => _AddTagViewState();
}

class _AddTagViewState extends State<AddTagView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return BlocListener<AddTagBloc, AddTagState>(
      listener: (context, state) {
        if (state is AddTagError) {
          UIToast.showToast(
            context: context,
            message: state.error,
            type: ToastType.error,
          );
        } else if (state is AddTagSuccess) {
          context.read<TagBloc>().add(TagFetched());
        }
        context.pop();
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create a New Tag",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: color.title,
                ),
              ),
              Text(
                "Enhance your knowledge organization by adding tags to your articles",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: color.caption,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: UIKitTextField(
                  placeholder: "Add your tag",
                  controller: _textEditingController,
                  rules: const [
                    ValidationRule.isEmtpy,
                  ],
                  fieldName: "Tag",
                ),
              ),
              UIKitButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<AddTagBloc>()
                        .add(AddTagRequested(tag: _textEditingController.text));
                  }
                },
                text: "Create Tag",
              )
            ],
          ),
        ),
      ),
    );
  }
}
