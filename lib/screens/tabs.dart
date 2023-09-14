import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/my_discovery.dart';
import 'package:news_app/screens/news_discovery.dart';
import 'package:news_app/providers/theme_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  
  void _selectedPage (int index){
  setState(() {
    _selectedPageIndex = index;
  });
  }
  @override
  Widget build(BuildContext context) { 
    final appThemeState = ref.watch(appThemeStateNotifier);
    Widget activePage = const HomeScreen();
   if(_selectedPageIndex == 1) {
    activePage = const NewsDiscoveryScreen();
   }
   if(_selectedPageIndex == 2){
    activePage = const FavoriteDiscoveryScreen();
   }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('changes'),
      // ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
         backgroundColor: appThemeState.isDarkModeEnable ?  const Color.fromARGB(255, 28, 25, 25) : Colors.white54,
         onTap: _selectedPage,
          currentIndex: _selectedPageIndex,
        //  (index) { if (index == 1) {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(builder: (context) => SearchScreen()), // Replace with your search screen
        //     );
        //   }
        // },
        items: [
          BottomNavigationBarItem(icon: 
           Icon(Icons.home,
                 color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,), 
          label: 'Home',   
       //    backgroundColor: appThemeState.isDarkModeEnable ? Colors.white : Colors.white,
           ),
          BottomNavigationBarItem(icon: 
           Icon(Icons.search_sharp,
          color:  appThemeState.isDarkModeEnable ? Colors.white : Colors.black,), 
          label: 'Discover',
          //    backgroundColor: appThemeState.isDarkModeEnable ? Colors.white54 : Colors.white,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined,
            color:  appThemeState.isDarkModeEnable ? Colors.white : Colors.black,), 
          label: ' My Discovery',)
        ],
        selectedLabelStyle: TextStyle(
    color: appThemeState.isDarkModeEnable ? Colors.white54 : Colors.white,

  ),
  unselectedLabelStyle: TextStyle(
    color: appThemeState.isDarkModeEnable ? Colors.white54 : Colors.white,
  
  ),),
    );
  }
}