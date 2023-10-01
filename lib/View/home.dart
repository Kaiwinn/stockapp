import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockapp/Model/coinModel.dart';
import 'package:stockapp/View/Components/item.dart';
import 'package:stockapp/View/Components/item2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 210, 85, 1),
              Color.fromARGB(255, 247, 188, 27),
            ],
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                    top: screenHeight * 0.025,
                    bottom: screenHeight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.01,
                          vertical: screenHeight * 0.005),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('Main portfolio',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ),
                    Text('Top 10 coins',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                    Text('Exprimental',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.05, left: screenWidth * 0.056),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ 8,995.20",
                      style: TextStyle(
                        fontSize: 21,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      height: screenHeight * 0.04,
                      width: screenWidth * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/icons/5.1.png'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  children: [
                    Text(
                      '+105% all time',
                      style: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 52, 52, 52)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                height: screenHeight * 0.7,
                width: screenWidth,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      // spreadRadius: 4, là khoảng cách mà bóng trổ lan ra là 4
                      spreadRadius: 4,
                      // blurRadius: 7, là độ mờ của bóng là 7
                      blurRadius: 7,

                      // offset: Offset(0, 3), là khoảng cách bóng đổ xuống dưới là 3 (truyền vào 2 giá trị x, y, là khoảng cách horizontal và  vertical)
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.08,
                      top: screenHeight * 0.02,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Assets",
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.add)
                        ]),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  isRefreshing
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: 4,
                          // shrinkWrap: true, để co lại nếu kích thước cha giới hạn.
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(), (Không thể cuộn)
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Item(
                              item: coinMarket![index],
                            );
                          }),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Row(
                      children: [
                        Text(
                          'Recommen to Buy',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Expanded(
                      child: Container(
                    width: screenWidth,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.01,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coinMarket!.length,
                        itemBuilder: (context, index) {
                          return Item2(
                            item: coinMarket![index],
                          );
                        },
                      ),
                    ),
                  )),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ]),
              )
            ]),
      ),
    );
  }

  bool isRefreshing = true;
  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
