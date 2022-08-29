import 'package:calcacutor_app/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var question ='';
  var answer = '';
  List<String> buttonslist =[
    'C','DEL','%','/',
    '9','8','7','*',
    '6','5','4','+',
    '3','2','1','-',
    '0','.','ANS','='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(question),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child:  Text(answer),
                    alignment: Alignment.topRight,
                  )
                ],
              ),
             
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              
              child: GridView.builder(
                itemCount: buttonslist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                 itemBuilder: (BuildContext context, int index){

                  //clear button
                  if(index==0){
                    return Button(
                      ontapped: (){
                        setState(() {
                          question = '';
                          answer = '';
                        });        
                      },
                      color: Colors.green, text: buttonslist[index], textcolor: Colors.white);
                  }

                  //delete button
                  if(index==1){
                    return Button(
                      ontapped: (){
                        setState(() {
                         
                          question = question.substring(0,question.length>0? question.length-1: 0);
                        });
                        
                      },
                      color: Colors.red, text: buttonslist[index], textcolor: Colors.white);
                  }
                  else if(index == buttonslist.length-1 || index == buttonslist.length-2){
                    return Button(
                      ontapped: (){
                       setState(() {
                         equalpressed();
                       });
                        
                      },
                      color: Colors.red, text: buttonslist[index], textcolor: Colors.white);


                  }
                  else{
                    return Button(
                      ontapped: (){
                        setState(() {
                          question += buttonslist[index];
                        });
                      },
                    color: isOperator(buttonslist[index])? Colors.deepOrange: Colors.white, 
                    text: buttonslist[index], 
                    textcolor: isOperator(buttonslist[index])? Colors.white: Colors.deepOrange);

                  }
                  
                 })
            ),
          )
        ],
      ),
    );
  }

  bool isOperator( String x){
    if(x == '+'|| x=='-' || x=='*' || x=='%' || x=='/'|| x=='='){
      return true;
    }
    return false;
  }

  void equalpressed(){
    String finalquestion = question;

    Parser p =Parser();
    Expression exp = p.parse(finalquestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer= eval.toString();

  }
}


