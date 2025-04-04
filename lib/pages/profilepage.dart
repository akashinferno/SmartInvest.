import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.account_circle, // Default user icon from Flutter
                size: 120,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Sudharshan.M", // Use Firebase display name or default
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Finance-Beginner", // Added a small bio/title
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Age"),
              subtitle: const Text("29"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.wc),
              title: const Text("Gender"),
              subtitle: const Text("Male"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(user?.email ??
                  "sudharshan.m@example.com"), // Use Firebase email or default
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Location"),
              subtitle: const Text("Chennai, India"), // Added a sample location
            ),
            const Divider(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // No action needed
                      },
                      child: const Text("Edit Profile"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // No action needed
                      },
                      child: const Text("Settings"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // No action needed
                      },
                      child: const Text("My Portfolio"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // No action needed
                      },
                      child: const Text("Transaction History"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // Navigator.pushReplacementNamed(context, "/login");
                  // You might want to navigate to the login screen after signing out
                },
                child: const Text("Sign Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
