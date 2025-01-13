import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/enum/menu_action.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/views/acc/acc_view.dart';
import 'package:autismcompanionsupport/views/diagnosis/diagnosis_view.dart';
import 'package:autismcompanionsupport/views/profile/profile_view.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {
  int _selectedIndex = 0;
  String _appBarTitle = "Profile";

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const ProfileView(),
    const AccView(),
    // const Text(
    //   'Index 2: Intervention',
    //   style: optionStyle,
    // ),
    const DiagnosisView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          _appBarTitle = 'Profile';
          break;
        case 1:
          _appBarTitle = 'Home';
          break;
        // case 2:
        //   _appBarTitle = 'Intervention';
        //   break;
        case 2:
          _appBarTitle = 'Diagnosis';
          break;
        default:
          _appBarTitle = 'Autism Companion';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BoldText(text: _appBarTitle),
        backgroundColor: AppColors.primaryColor,
        actions: [
          if (_selectedIndex == 1) // Assuming 'Home' is at index 1
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Implement edit functionality for rearranging or deleting categories
            },
          ),
        ...menuOptionsList(context)],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.school),
        //   label: 'Intervention',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.admin_panel_settings),
          label: 'Diagnosis',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 247, 180, 63),
      unselectedItemColor: const Color(0xFF1D2C33),
      onTap: _onItemTapped,
    );
  }

}

List<PopupMenuButton<MenuAction>> menuOptionsList(BuildContext context) {
  return [
    PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch(value) {
          case MenuAction.logout:
            final shouldLogout = await showLogoutDialog(context);
            if(shouldLogout) {
              await AuthService.firebase().logOut();
              if(context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute, 
                  (_) => false,
                );
              }
            } else {
              return;
            }
            break;
        }
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem<MenuAction>(
            value: MenuAction.logout, 
            child: Text('Logout'),
          ),
        ];
      },
    ),
  ];
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            }, child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            }, child: const Text('Logout'),
          ),
        ]
      );
    }
  ).then((value) => value ?? false);
}