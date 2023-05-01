import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'FriendNFlix';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF7F5), // set background to the shade of red here
        body: const MyStatefulWidget(),

        appBar: AppBar(
          backgroundColor: Color(0xFFFFF7F5),
          elevation: 0,
          toolbarHeight: 90, // set the height of the AppBar
          actions: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                const Color(0xFFAF3037),
                BlendMode.srcIn,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                iconSize: 50, // increase the size of the icon
              ),
            ),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                const Color(0xFFAF3037),
                BlendMode.srcIn,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.message),
                iconSize: 50, // increase the size of the icon
              ),
            ),
          ],
          leading: SizedBox(
            width: 300, // increase the width of the logo
            height: 300, // increase the height of the logo
            child: Image.asset(
              'assets/images/logo1.png',
              width: 300,
              height: 300,
            ),
          ),
          centerTitle: true,
          title: Text(
            'FriendNFlix',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 36, // increase the font size of the title
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
          iconSize: 40,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Create Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFF7F5), // set background to the shade of red here
        body: Column(
          //child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.0000000015, // move everything down by x percent
                      ),

                      SizedBox(height: 8),
                      Container(
                        width: 280,
                        height: 590,

                        decoration: BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 50,
                              spreadRadius: 5,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 2),
                                Image.asset(
                                  'assets/images/sampleProfile.png',
                                  width: 90,
                                  height: 90,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    '@alexa_r posted',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 21,
                                      //fontStyle: FontStyle.italic,
                                      //fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 2),
                            Image.asset(
                              'assets/images/AlpinistExample.jpg',
                              width: 200,
                              height: 200,
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '                                                 Show details',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            SizedBox(height: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFFAE20D),
                                  size: 40,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFFAE20D),
                                  size: 40,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFFAE20D),
                                  size: 40,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFFAE20D),
                                  size: 40,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(250, 226, 13, 0.45),
                                  size: 40,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 150, // move up and down (the review info that's being displayed)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Title:               ',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Thoughts:      ',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Phone Level: ',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Watch Date:  ',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Tags:              ',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )  ,
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}