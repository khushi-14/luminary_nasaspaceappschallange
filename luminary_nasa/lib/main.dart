// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:luminary_nasa/google_sign_in_button.dart';
import 'package:luminary_nasa/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
              scaffoldBackgroundColor: Color.fromARGB(255, 0, 9, 25)),
          home: MyHomePage(
            title: 'Home',
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 3;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Latest',
      style: optionStyle,
    ),
    Text(
      'Index 1: Learn',
      style: optionStyle,
    ),
    Text(
      'Index 2: Play',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 14, 31, 56);
    const mainColor = Color.fromARGB(255, 0, 9, 25);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_name.png',
              fit: BoxFit.contain,
              height: 192,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Card(
            color: Color(0xffE8E6E6),
            elevation: 8,
            shadowColor: Colors.grey,
            margin: EdgeInsets.all(20),
            child: SizedBox(
              width: 500,
              height: 120,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.satellite_alt_sharp,
                    color: Color.fromARGB(255, 14, 31, 56),
                    size: 60.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.5,
                      ),
                      Text(
                        'Where is the Parker Solar Probe?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Latest Update: 2022-09-30 22:30:14',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 37, 37, 37)),
                      ),
                      Text(
                        'Elapse Days: 1510.47',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 37, 37, 37)),
                      ),
                      Text(
                        'Distance From Sun: 94918865.29 Km',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 37, 37, 37)),
                      ),
                      Text(
                        'Velocity: 25.27 Km/s',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 37, 37, 37)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            '    Recent Articles: ',
            style: TextStyle(
              color: Color(0xffFFB400),
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            // leading: SizedBox(
            //   height: 150,
            //   width: 150,
            //   child: Image.asset('assets/images/psp1.jpg'),
            // ),
            leading: Container(
              height: 250,
              width: 80,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://solarsystem.nasa.gov/system/content_pages/main_images/1708_Parker-Solar-Probe_ObservingSun_1280.jpg"),
                      fit: BoxFit.cover)),
            ),
            title: Text(
              'Parker Solar Probe Captures its First Images of Venus Surface in Visible Light, Confirmed',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300],
                  fontSize: 15),
            ),
            subtitle: Text(
              '8 months ago',
              style: TextStyle(color: Colors.grey[300], fontSize: 12),
            ),
            isThreeLine: true,
          ),
          SizedBox(
            height: 2,
          ),
          ListTile(
            // leading: SizedBox(
            //   height: 150,
            //   width: 150,
            //   child: Image.asset('assets/images/psp1.jpg'),
            // ),
            leading: Container(
              height: 250,
              width: 80,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2020/01/solar_orbiter_and_parker_solar_probe/21818017-1-eng-GB/Solar_Orbiter_and_Parker_Solar_Probe_pillars.jpg"),
                      fit: BoxFit.cover)),
            ),
            title: Text(
              'NASA Enters the Solar Atmosphere for the First Time, Bringing New Discoveries',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300],
                  fontSize: 15),
            ),
            subtitle: Text(
              '10 months ago',
              style: TextStyle(color: Colors.grey[300], fontSize: 12),
            ),
            isThreeLine: true,
          ),
          SizedBox(
            height: 2,
          ),
          ListTile(
            // leading: SizedBox(
            //   height: 150,
            //   width: 150,
            //   child: Image.asset('assets/images/psp1.jpg'),
            // ),
            leading: Container(
              height: 250,
              width: 80,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://space.skyrocket.de/img_sat/solar-probe-plus__2.jpg"),
                      fit: BoxFit.cover)),
            ),
            title: Text(
              'NASA Scientist Kelly Korreck on the Journey to the Sun, and What It Takes to Get There',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300],
                  fontSize: 15),
            ),
            subtitle: Text(
              '10 months ago',
              style: TextStyle(color: Colors.grey[300], fontSize: 12),
            ),
            isThreeLine: true,
          ),
          SizedBox(
            height: 2,
          ),
          ListTile(
            // leading: SizedBox(
            //   height: 150,
            //   width: 150,
            //   child: Image.asset('assets/images/psp1.jpg'),
            // ),
            leading: Container(
              height: 250,
              width: 80,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                          "http://spaceflightnow.com/wp-content/uploads/2018/07/Parker-Solar-Probe-Processing-678x512.jpg"),
                      fit: BoxFit.cover)),
            ),
            title: Text(
              'NASA Launches X-ray Spectrometer Mission to Probe Mysteries of Solar Corona',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300],
                  fontSize: 15),
            ),
            subtitle: Text(
              'about 1 year ago',
              style: TextStyle(color: Colors.grey[300], fontSize: 12),
            ),
            isThreeLine: true,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'Latest',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Learn',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              label: 'Play',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: primaryColor,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xffFFB400),
          onTap: (int index) {
            switch (index) {
              case 0:
                // only scroll to top when current index is selected.
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
            }
          }),
    );
  }
}
