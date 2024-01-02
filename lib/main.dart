import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_user_api_using_provider/provider/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          if (userProvider.users.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users;
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('${user[index].picture?.medium}')),
                  title: Text(
                    '${user[index].name?.first ?? ''} ${user[index].name?.last ?? ''}',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
