import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(title: 'Snack bar'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required String title}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final snackBar = SnackBar(
    content: const Text('Successfully Saved'),
    backgroundColor: Colors.redAccent,
    duration: const Duration(seconds: 1),
    action: SnackBarAction(
      onPressed: () {},
      label: 'Undo',
    ),
  );
  String delete = 'No Choice Made';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              delete = 'you selected yes';
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              delete = 'you selected No';
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        )
                      ],
                      title: const Text('Deleting'),
                      content: const Text('Are you sure you want to delete?'),
                    );
                  },
                );
              },
              child: const Text('Delete'),
            ),
            Text(delete)
          ],
        ),
      ),
    );
  }
}
