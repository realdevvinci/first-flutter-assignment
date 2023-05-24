import 'fetching.dart';
import 'package:flutter_assignment/provider/currencieData.dart';

class Calcuation {
  Future<double> currenciesCalc(
      String firstCurrencie, String secondCurrencie, double value) async {
    var myMap = await Fetching().fetchingData();

    if (Data.resposeCode == 200) {
      double firstRate = myMap["rates"][firstCurrencie];
      double secondRate = myMap["rates"][secondCurrencie];

      return (value / firstRate) * secondRate;
    }
    return -1;
  }
}
