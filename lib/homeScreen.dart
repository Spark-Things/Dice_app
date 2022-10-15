import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
     int leftdicenum = 1;
     int rightdicenum = 1;
     var moves = 0;
      late AnimationController _controller;
      late CurvedAnimation animation;

     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =  AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
         setState(() {
      
    });
      print(_controller.value);});
 
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
          moves = leftdicenum+ rightdicenum;
          setState(() {
            
         leftdicenum = Random().nextInt(6)+1;
         rightdicenum = Random().nextInt(6)+1;
         moves = leftdicenum + rightdicenum;
    });
        print('completed');
        _controller.reverse();
      }
    });
  }

   void roll(){
       _controller.forward();
    
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicee'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                        height: 200-(animation.value)*200,
                        image: AssetImage('images/dice-${leftdicenum}.png'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                   child: GestureDetector(
                    onDoubleTap: roll,
                     child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                              height: 200-(animation.value)*200,
                        image: AssetImage('images/dice-${rightdicenum}.png')
                      ),
                     ),
                   ),
                    )
              ],
            ),
            ElevatedButton(
              onPressed: roll,
              child: Text("Roll",style: TextStyle(fontWeight: FontWeight.bold ),),
            ),
            Text('Total moves is ${moves}')
          ],
        ),
      ),
    );
  }
}
