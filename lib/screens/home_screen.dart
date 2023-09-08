import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/main_drawer.dart';
import 'package:news_app/widgets/news_card.dart';

import 'next_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedPageIndex = 0;

  late ProviderContainer _container; // Declare a ProviderContainer variable
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   // Obtain a reference to the ProviderContainer using dependOnInheritedWidgetOfExactType
  //   _container = ProviderScope.containerOf(context);
  // }

  // Function to get the appropriate greeting based on the time of day
  String getGreeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour < 12) {
      return 'Good Morning...';
    } else if (hour < 18) {
      return 'Good Afternoon...';
    } else {
      return 'Good Evening...';
    }
  }

  Future<void> _refreshNewsData() async {
    // Call the function to reload your news data here.
    await ref.read(newsProvider.notifier).loadNews();

    // Notify Riverpod to rebuild the UI by reading the news data again.
   ref.read(newsProvider); // This will trigger a rebuild.
  }

  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsProvider).newsModel;
    final isLoading = ref.watch(newsProvider).isLoading;
    final appThemeState = ref.watch(appThemeStateNotifier);

   return Scaffold(
  key: _scaffoldKey,
    backgroundColor:  appThemeState.isDarkModeEnable
              ? const Color.fromARGB(255, 28, 25, 25)
              : Colors.white10,
  drawer: const MainDrawer(),
  body: RefreshIndicator(
    onRefresh: _refreshNewsData, // Call the refresh function here
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 150.0,
          backgroundColor: appThemeState.isDarkModeEnable
              ?  const Color.fromARGB(255, 28, 25, 25)
              :  Colors.white70,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Headlines for Today",
              style: GoogleFonts.poppins(
                color: appThemeState.isDarkModeEnable
                    ? Colors.white
                    : const Color.fromARGB(255, 28, 25, 25),
              ),
            ),
            centerTitle: true,
          ),
          leading: IconButton(
    icon: const Icon(
      Icons.menu,
      color: Colors.black, // Set the color to black
    ),
    onPressed: () {
        _scaffoldKey.currentState?.openDrawer();
    },
  ),
),
      
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // Your list item builder here
              return NewsCard(article: news.results![index]);
            },
            childCount: news.results!.length,
          ),
        ),
           SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Align(
      alignment: Alignment.center,
      child: TextButton.icon(
        onPressed: () {
         Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const NextPage(),
    ),
  );
        },
        icon: Icon(
          Icons.navigate_next_outlined,
          color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
        ),
        label: Text(
          'Next Page',
          style: TextStyle(
            color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
                // Add more text style customization as needed
              ),
            ),
          ),
        ),
      ),
            ),
      ],
    ),
  ),
);
  }
}