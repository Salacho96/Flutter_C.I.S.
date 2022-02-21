import 'package:flutter/material.dart';

void main(){

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "C.I.S: The App",
      home: SIForm(),

      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
    )//MaterialApp
  );
}


class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm>{

  final _currencies = ['USD','COP','EUR'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = 'USD';
  var displayResult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();



  @override
  Widget build(BuildContext context){

    return Scaffold(
       backgroundColor: Colors.white,

      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('C.I.S: The App'),
      ),//appBar

      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[

            getImageAsset(),

            Padding(
              padding:EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: principalController,
                decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter Principal e.g. 1200',
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                  )//OutlineInputBorder
                ),//Input Decoration
              )//TextField
            ),//Padding


            Padding(
              padding:EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: roiController,
                decoration: InputDecoration(
                  labelText: 'Rate of interest',
                  hintText: 'in porcent',
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                  )//OutlineInputBorder
                ),//Input Decoration
              )//TextField
            ),//Padding

            Row(
              children: <Widget>[

                Expanded(
                  child: TextField(
                  keyboardType: TextInputType.number,
                  controller: termController,
                  decoration: InputDecoration(
                    labelText: 'Term',
                    hintText: 'Time in Years',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                      )//OutlineInputBorder
                    ),//Input Decoration
                  )//TextField
                ),//Expanded

                Container(width: _minimumPadding*5,),

                Expanded(
                  child: DropdownButton<String>(
                  items: _currencies.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );//DropdownMenuItem
                  }).toList(),
                  value: _currentItemSelected,
                  onChanged: (String? newValueSelected) {
                    _onDropdownItemSelected(newValueSelected!);
                    },//onchanged
                  )//DropdownButton
        
                )//Expanded

                
              ]//widget[]
            ),//Row


            

            Padding(
              padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
              child: Row(children: <Widget>[

              Expanded( 
                child: RaisedButton(
                  child: Text('Calculate'),
                  onPressed: (){
                    setState(() {
                      this.displayResult = _calculateTotalReturns();
                    });
                  },
                ),
              ),


              Container(width: _minimumPadding*5,),



              Expanded(
                child: RaisedButton(
                  child: Text('Reset'),
                  onPressed:(){
                    setState(() {
                      _reset();
                    });
                  },
                ),
              ),


              ],)),


              Padding(
                padding: EdgeInsets.all(_minimumPadding*2),
                child: Text('',
                            textAlign: TextAlign.center,),
                      ),

              
              Padding(
                padding: EdgeInsets.all(_minimumPadding*2),
                child: Text('',
                            textAlign: TextAlign.center,),
                      ),



              Padding(
                padding: EdgeInsets.all(_minimumPadding*2),
                child: Text(this.displayResult,
                            textAlign: TextAlign.center,),),

              Padding(
                padding: EdgeInsets.all(_minimumPadding*2),
                child: Text('DEVELOPED BY:',
                            textAlign: TextAlign.center,),),
            

                Padding(
                padding: EdgeInsets.all(_minimumPadding*2),
                child: Text('Andres Felipe Salazar Rojas.',
                            textAlign: TextAlign.center,),
                      )





            

          ],//widget[]
        ),//column
      ),//container
    );//scaffold
  }


  Widget getImageAsset(){

    AssetImage assetImage = AssetImage('images/bank.jpeg');
    Image image = Image(image:assetImage, width: 125.0, height: 125.0,);

    return Container(child: image,margin: EdgeInsets.all( _minimumPadding * 10),);

  }

  void _onDropdownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected=newValueSelected;
    });
  }
  String _calculateTotalReturns(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    
    double totalAmountPayable = principal + (principal*roi*term) / 100;

    String  result = 'Despues de $term años, su inversion tendra un total de $totalAmountPayable';
    return result;
  }

  void _reset(){
    principalController.text='';
    roiController.text='';
    termController.text='';
    displayResult='';
    _currentItemSelected=_currencies[0];

  }
  
}