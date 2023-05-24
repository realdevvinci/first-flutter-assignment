import 'package:flutter/material.dart';
import 'package:flutter_assignment/services/fetching.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/provider/currencieData.dart';

class ChangeCurrencie extends StatefulWidget {
  @override
  State<ChangeCurrencie> createState() => _ChangeCurrencieState();
}

class _ChangeCurrencieState extends State<ChangeCurrencie> {
  List<TextButton> currenciesBtnList = [
    TextButton(
      onPressed: () {},
      child: Text(""),
    )
  ];

  listCurrncies() async {
    List<TextButton> currenciesWidgts = [];
    var textButtonFromList = await Fetching().getCurrencies();
    if (Data.resposeCode != 200) {
      List<TextButton> errorBtn = [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Erro Code: ${Data.resposeCode}",
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.red,
                  fontWeight: FontWeight.w800)),
        )
      ];
      return errorBtn;
    }

    textButtonFromList.forEach((element) {
      var x = TextButton(


        onPressed: () {
          var forEachProvider = Provider.of<Data>(context, listen: false);
          if (forEachProvider.choosing) {
            forEachProvider.setFirst(element);
          } else {
            forEachProvider.setSecond(element);
          }
        },
        child: Text("$element"),
      );

      currenciesWidgts.add(x);
    });

    return currenciesWidgts;
  }

  void initState() {
    initList();
  }

  void initList() async {
    var newList = await listCurrncies();

    setState(() {
      currenciesBtnList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<Data>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${myProvider.choosing ? myProvider.firstCurrencie : myProvider.secondCurrencie}"),
      ),
      body: SafeArea(
        child: ListView(
          children: currenciesBtnList,
        ),
      ),
    );
  }
}
