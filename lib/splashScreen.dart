import 'package:flutter/material.dart';
import '../widgets/background.dart';
import 'second.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
          children: [
            Column(
              children: [
                Image.asset('assets/images/Amjad.png'),
                Center(
                  child: Text('Pediatric Facial Rehab',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 33,
                    color: Color.fromRGBO(244, 83, 68, 1),
                    fontFamily: 'Roboto'
                  ),),
                )
              ],
            ),
            Column(
              children: [
                Stack(
                  children: [

                    Column(children: [
                      SizedBox(height: 20,),
                      Center(
                        child: Text('WELCOME',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(244, 83, 68, 1),

                        ),),
                      ),
                      SizedBox(height: 25,),
                      Text('   This mobile application was created to assist\n '
                          'physiotherapists in the rehabilitation of children\n'
                          ' and adolescents with facial palsy by using funny\n'
                          ' and adorable characters that the children adore.\n'
                          '   The application, with the help of AI, uses the\n'
                          ' front camera to recognize, correct, and record\n'
                          ' facial movements in order to improve and\n'
                          ' accelerate the recovery process, with a reminder\n '
                          'added to remind patients about their daily timed\n'
                          ' home-program sessions.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(244, 83, 68, 1),


                      ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height*0.01 ,),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              Navigator.push (context, MaterialPageRoute(builder: (context)=>secondScreen()));


                            }, child: Text('SKIP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(244, 83, 68, 1),


                            ),
                            )
                            ,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                          ],
                        ),
                      )


                    ],)
                  ],
                )
              ],
            )
          ],
        ),

      );
  }
}
