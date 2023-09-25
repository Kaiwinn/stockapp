import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;

  Item({this.item});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.015,
      ),
      child: Container(
        child: Row(
          children: [
            Container(
              height: screenHeight * 0.05,
              child: Image.network(item.image),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Column(
              children: [
                Text(
                  item.id,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                ),
                Text(
                  '0.3 ' + item.symbol,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.2,
              child: Sparkline(
                data: item.sparklineIn7D.price,
                lineWidth: 2.0,
                lineColor: Color.fromARGB(255, 255, 72, 72),
                fillMode: FillMode.below,
                fillGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.7],
                  colors: [
                    Color.fromARGB(255, 255, 72, 72),
                    Color.fromARGB(255, 254, 218, 218).withOpacity(0.1),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  '\$ ' + item.currentPrice.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                Row(children: [
                  Text(item.priceChange24H.toStringAsFixed(2),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.grey)),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  Text(item.marketCapChangePercentage24H.toStringAsFixed(2),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.grey)),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
