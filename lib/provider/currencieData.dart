import 'package:flutter/material.dart';
import "package:flutter_assignment/services/fetching.dart";
import 'package:flutter_assignment/services/calculation.dart';

class Data with ChangeNotifier {
  String firstCurrencie = "USD";
  String secondCurrencie = "USD";
  bool choosing = true;
  double exchangeValue = 1.0;
  double calcuatedPrice = 1.0;
  static int resposeCode = 200;

  void setFirst(String x) {
    firstCurrencie = x;
    notifyListeners();
  }

  void setSecond(String x) {
    secondCurrencie = x;
    notifyListeners();
  }

  void setChoosing(bool changingTo) {
    choosing = changingTo;
    notifyListeners();
  }

  void setValue(double value) {
    exchangeValue = value;
    notifyListeners();
  }

  void calculate() async {
    var Calc = Calcuation();

    calcuatedPrice = await Calc.currenciesCalc(
        firstCurrencie, secondCurrencie, exchangeValue);
    notifyListeners();
  }

  void setResposeCode(int code) {
    resposeCode = code;
    notifyListeners();
  }
}
