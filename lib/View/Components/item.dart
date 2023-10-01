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
            Expanded(
              flex: 2,
              child: Container(
                height: screenHeight * 0.05,
                child: Image.network(item.image),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.id,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  Text(
                    '0.3 ' + item.symbol,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: screenHeight * 0.05,
                child: Sparkline(
                  data: item.sparklineIn7D.price,
                  lineWidth: 2.0,
                  lineColor: item.marketCapChangePercentage24H > 0
                      ? Color.fromARGB(255, 255, 72, 72)
                      : Color.fromARGB(255, 48, 208, 112),
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.7],
                    colors: item.marketCapChangePercentage24H > 0
                        ? [
                            Color.fromARGB(255, 255, 72, 72),
                            Color.fromARGB(255, 254, 218, 218).withOpacity(0.5),
                          ]
                        : [
                            Color.fromARGB(255, 72, 255, 145),
                            Color.fromARGB(255, 218, 254, 218).withOpacity(0.5),
                          ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.01,
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Text(
                    '\$ ' + item.currentPrice.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Row(children: [
                    Text(
                        item.priceChange24H.toString().contains('-')
                            ? '-\$' +
                                item.priceChange24H
                                    .toStringAsFixed(2)
                                    .toString()
                                    .replaceAll('-', '')
                            : '\$' + item.priceChange24H.toStringAsFixed(2),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.grey)),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    Text(
                        item.marketCapChangePercentage24H.toStringAsFixed(2) +
                            '%',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: item.marketCapChangePercentage24H > 0
                                ? Colors.green
                                : Colors.red))
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
