import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrmMinhaContaWidget extends StatefulWidget {
  const FrmMinhaContaWidget({super.key});

  @override
  State<FrmMinhaContaWidget> createState() => _FrmMinhaContaWidgetState();
}

class _FrmMinhaContaWidgetState extends State<FrmMinhaContaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Mock de dados do usuário
  final Map<String, String> mockUser = {
    'displayName': 'Rafael Maranduba',
    'userTitle': 'Badass Busybody',
    'email': 'rafael@example.com',
    'avatar': 'assets/logo.jpeg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey, Colors.white],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(mockUser['avatar']!),
                    ),
                    // Logout
                    IconButton(
                      icon: Icon(Icons.logout_rounded, color: Colors.white),
                      onPressed: () {
                        print('Logout pressed');
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Nome e título
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mockUser['displayName']!,
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    mockUser['userTitle']!,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    mockUser['email']!,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Opções
            buildMenuButton(context, 'Edit Profile', () {
              print('Edit Profile pressed');
            }),
            buildMenuButton(context, 'Change Password', () {
              print('Change Password pressed');
            }),
            buildMenuButton(context, 'Notification Settings', () {
              print('Notification Settings pressed');
            }),
            buildMenuButton(context, 'Tutorial', () {
              print('Tutorial pressed');
            }),
            buildMenuButton(context, 'Privacy Policy', () {
              print('Privacy Policy pressed');
            }),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: GoogleFonts.lexend(fontSize: 16)),
                Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
