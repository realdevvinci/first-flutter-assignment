import 'package:flutter/material.dart';
import 'package:flutter_assignment/application/changeCurrencie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/provider/currencieData.dart';
import 'package:flutter_assignment/services/constant.dart';

class FirstPage extends StatefulWidget {

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  var firstPageProvider = Provider.of<Data>;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),

      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              buildElevatedButton(context),
              buildElevatedButton2(context),
              SizedBox(
                width: 200,
                child: TextField(onChanged: (v){

                  if(v.isNotEmpty){

                    if(isNumeric(v)){
                      firstPageProvider(context, listen: false).setValue(double.parse(v));
                      firstPageProvider(context, listen: false).calculate();
                    }  else{
                      dataTypeAlertPC(context);
                    }

                  }


                }, decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a Exchange Value',
                ), keyboardType: TextInputType.number
                ),
              ),
              Text( Data.resposeCode==200 ? "Exchange Total:${firstPageProvider(context).calcuatedPrice.toStringAsFixed(2)}" : "Error Code: ${Data.resposeCode} mostly fetching error" , style: kTextStyler(),)

            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton2(BuildContext context) {
    return ElevatedButton(
                onPressed: () {

                  Provider.of<Data>(context , listen: false).setChoosing(false);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ChangeCurrencie();
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Provider.of<Data>(context).secondCurrencie ,  style: kTextStyler(),),
                ));
  }

  ElevatedButton buildElevatedButton(BuildContext context) {
    return ElevatedButton(
                onPressed: () {

                  Provider.of<Data>(context , listen: false).setChoosing(true);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ChangeCurrencie();
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Provider.of<Data>(context).firstCurrencie , style:kTextStyler(),),
                ) );
  }
}


bool isNumeric(String string) {
  final numericRegex =
  RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  return numericRegex.hasMatch(string);
}

dataTypeAlertPC(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("Ops!"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Wrong input Type"),
    content: Text("Please enter numbers only."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}