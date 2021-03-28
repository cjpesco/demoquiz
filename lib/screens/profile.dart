import 'package:demoquiz/services/services.dart';
import 'package:demoquiz/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    User user = Provider.of<User>(context);

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (user.photoURL != null)
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.photoURL),
                    ),
                  ),
                ),
              Text(user.email ?? '',
                  style: Theme.of(context).textTheme.headline5),
              Spacer(),
              if (report != null)
                Text('${report.total ?? 0}',
                    style: Theme.of(context).textTheme.headline2),
              Text('Quizzes Completed',
                  style: Theme.of(context).textTheme.subtitle1),
              Spacer(),
              TextButton(
                  child: Text('logout'),
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.red),
                  onPressed: () async {
                    await auth.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }),
              Spacer()
            ],
          ),
        ),
      );
    } else {
      return LoadingScreen();
    }
  }
}
