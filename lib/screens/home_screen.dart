import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final String? huddleId;

  const HomeScreen({super.key, required this.name, this.huddleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huddle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome, $name!',
                style: Theme.of(context).textTheme.headlineMedium),
            if (huddleId != null) ...[
              const SizedBox(height: 8),
              Text('@$huddleId'),
            ],
            const SizedBox(height: 16),
            const Text('Friends, Inbox and Rooms will come here.'),
          ],
        ),
      ),
    );
  }
}