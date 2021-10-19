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
  String location = 'No location chosen';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
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
            Text(delete),
            ElevatedButton(
              onPressed: () async {
                final String loc = await showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Choose Your Location'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'Kenya');
                          },
                          child: const Text('Kenya'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'America');
                          },
                          child: const Text('America'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'Europe');
                          },
                          child: const Text('Europe'),
                        )
                      ],
                    );
                  },
                );
                setState(() {
                  location = loc;
                });
              },
              child: const Text('Choose Location'),
            ),
            Text(location),
            ElevatedButton(
              onPressed: () {
                scaffoldKey.currentState?.showBottomSheet((context) {
                  return Container(
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            'Are you sure you want to delete?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    height: 110,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  );
                });
              },
              child: const Text('Bottom Sheet'),
            )
          ],
        ),
      ),
    );
  }
}
