import 'package:flutter/material.dart';
import 'package:project_hub_design/screens/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _State();
}

class _State extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 24
          ),
        ),
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/itachi.jpg'),
                radius: 50.0,
              ),
            ),
            Divider(
              height: 90.0,
              color: Colors.grey[800],
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: .bold,
                letterSpacing: 2.0
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'So Chetra',
              style: TextStyle(
                color: Colors.lightBlue[700],
                fontSize: 24,
                fontWeight: .w600,
                letterSpacing: 1.0
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              'CURRENT SO CHETRA LEVEL',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: .bold,
                  letterSpacing: 2.0
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '5',
              style: TextStyle(
                  color: Colors.lightBlue[700],
                  fontSize: 24,
                  fontWeight: .w600,
                  letterSpacing: 1.0
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  'nornsochetra@gmail.com',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontWeight: .w500,
                    letterSpacing: 2.0
                  ),
                )
              ],
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                Icon(
                  Icons.phone_enabled,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  '098796787',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      fontWeight: .w500,
                      letterSpacing: 2.0
                  ),
                )
              ],
            ),
            SizedBox(height: 40.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>  HomeScreen()
                    ),
                  );
                },
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    print('you have log out from account');
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white70,
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
