import 'package:flutter/material.dart';
import 'package:x_ray2/fetures/home/views/history_view.dart';
import 'package:x_ray2/fetures/home/views/home_view.dart';
import 'package:x_ray2/fetures/home/views/notifi_view.dart';



class CustomBottomNavigationBar extends StatefulWidget {
  static String id='CustomBottomNavigationBar';

  const CustomBottomNavigationBar({super.key});
  @override
_CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    HistoryView(),
        NotifiView(),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(Icons.home, 'Home', 0),
          _buildBottomNavigationBarItem(Icons.history, 'history', 1),
          _buildBottomNavigationBarItem(Icons.notifications, 'Notifications', 2),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, String label, int index, {bool isCentral = false}) {
    return BottomNavigationBarItem(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isCentral ? 40 : 24),
          if (_selectedIndex == index) ...[
            SizedBox(width: 8),
            Text(label),
          ],
        ],
      ),
      label: '',
    );
  }
}