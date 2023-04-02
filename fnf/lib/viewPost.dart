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
                            width: 300,
                            height: 300,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '                                                        Show details',
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
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFAE20D),
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFAE20D),
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFAE20D),
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                color: Color.fromRGBO(250, 226, 13, 0.45),
                                size: 50,
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.thumb_down,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 60, // Adjust this value to move the widget down more or less
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    ' Add Comment',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'View Comment Section ',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
