import 'package:flutter/material.dart';
import 'package:stockapp/View/selectCoin.dart';

class Item2 extends StatelessWidget {
  var item;
  Item2({this.item});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectCoin(
                        selectedItem: item,
                      )));
        },
        child: Container(
          padding: EdgeInsets.only(
            left: screenWidth * 0.03,
            right: screenWidth * 0.03,
            top: screenHeight * 0.01,
            bottom: screenHeight * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color.fromARGB(255, 45, 45, 45).withOpacity(0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.03,
                child: Image.network(
                  item.image,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                item.id,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
