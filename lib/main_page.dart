import 'package:article_bookmark/article_bookmark.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foundation/foundation.dart';
import 'package:network/network.dart';
import 'package:rss/rss.dart';
import 'package:user/view/menu/user_menu_page.dart';

class MainPage extends StatefulWidget {
  const MainPage._();

  @override
  State<MainPage> createState() => _MainPageState();

  static Widget create() {
    return BlocProvider(
      create: (context) {
        return BookmarkClipboardBloc(
          articleRepository: ArticleRepositoryImpl(
            client: HttpNetwork.client,
          ),
        );
      },
      child: const MainPage._(),
    );
  }
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(const Duration(milliseconds: 1000), () {
      showBookmarkClipboardIfNeeded();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      showBookmarkClipboardIfNeeded();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void showBookmarkClipboardIfNeeded() async {
    ClipboardData? clipboardData = await Clipboard.getData("text/plain");
    String? clipboardText = clipboardData?.text;

    if (clipboardText != null &&
        clipboardText.isValidURL() &&
        context.mounted) {
      BookmarkClipboardState state =
          context.read<BookmarkClipboardBloc>().state;
      context
          .read<BookmarkClipboardBloc>()
          .add(BookmarkClipboardLinkRequested(link: clipboardText));

      if (state is BookmarkClipboardClosed) {
        BookmarkClipboard.show(
            context: context, bloc: context.read<BookmarkClipboardBloc>());
      }
    }
  }

  static final List<Widget> _pages = <Widget>[
    ArticleBookmarkPage.create(),
    RssPage.create(),
    UserMenuPage.create(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            label: "RSS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}