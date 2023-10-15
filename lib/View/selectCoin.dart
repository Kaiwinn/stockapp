import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stockapp/Model/chartModel.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class SelectCoin extends StatefulWidget {
  var selectedItem;

  SelectCoin({this.selectedItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    getChart();
    // Khai báo Trackball
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: screenHeight,
      width: screenWidth,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                        height: screenHeight * 0.07,
                        child: Image.network(widget.selectedItem.image)),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedItem.id,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 14, 14, 14)),
                        ),
                        Text(
                          widget.selectedItem.symbol,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 148, 148, 148)),
                        )
                      ],
                    ),
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.selectedItem.currentPrice.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 148, 148, 148)),
                      ),
                      Text(
                        widget.selectedItem.marketCapChangePercentage24H
                                .toString() +
                            '%',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: widget.selectedItem
                                        .marketCapChangePercentage24H >=
                                    0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  )
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Low',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 148, 148, 148)),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      '\$' + widget.selectedItem.low24H.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 40, 40, 40)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'High',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 148, 148, 148)),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      '\$' + widget.selectedItem.high24H.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 40, 40, 40)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 148, 148, 148)),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      '\$' + widget.selectedItem.totalVolume.toString() + ' M',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 40, 40, 40)),
                    )
                  ],
                ),
              ],
            ),
          ),
          (itemChart != null && itemChart!.isNotEmpty)
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  child: SfCartesianChart(
                    trackballBehavior: trackballBehavior,
                    zoomPanBehavior: ZoomPanBehavior(
                        //  cho phép kéo và đặt ngón tay lên màn hình
                        enablePinching: true,
                        zoomMode: ZoomMode.x),
                    series: <CandleSeries>[
                      CandleSeries<ChartModel, int>(
                        enableSolidCandles: true,
                        enableTooltip: true,
                        bullColor: Colors.green,
                        bearColor: Colors.red,
                        dataSource: itemChart!,
                        xValueMapper: (ChartModel sales, _) => sales.timestamp,
                        lowValueMapper: (ChartModel sales, _) => sales.low,
                        highValueMapper: (ChartModel sales, _) => sales.high,
                        openValueMapper: (ChartModel sales, _) => sales.open,
                        closeValueMapper: (ChartModel sales, _) => sales.close,
                        animationDuration: 55,
                      )
                    ],
                  ))
              : Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                  child: CircularProgressIndicator(),
                ),
          Container(
            height: screenWidth * 0.1,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: text.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelectedText = [
                          false,
                          false,
                          false,
                          false,
                          false,
                          false
                        ];
                        isSelectedText[index] = true;
                      });
                      setDays(text[index]);
                      getChart();
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.013),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelectedText[index] == true
                            ? Color.fromARGB(255, 216, 219, 46).withOpacity(0.3)
                            : Colors.transparent,
                      ),
                      child: Text(
                        text[index],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 14, 14, 14)),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05),
                width: screenWidth,
                child: Text(
                  "News",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 14, 14, 14)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      textAlign: TextAlign.justify,
                    )),
                    Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 156, 156, 156),
                        ),
                        width: screenWidth * 0.15,
                        height: screenHeight * 0.07,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ))
                  ],
                ),
              )
            ],
          )),
          Container(
            child: Column(
              children: [
                Container(
                  height: 0.5,
                  color: Color.fromARGB(77, 96, 96, 96), // Màu của đường viền
                ),
                Container(
                  height: screenHeight * 0.09,
                  width: screenWidth,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: screenWidth * 0.05,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                              vertical: screenHeight * 0.013),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 228, 190, 3),
                          ),
                          child: Row(children: [
                            Icon(Icons.add),
                            Text('Add to portfolio',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 39, 39, 39)))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.018,
                              vertical: screenHeight * 0.013),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(208, 199, 199, 199),
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: const Color.fromARGB(255, 54, 54, 54),
                          ),
                        )
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];

  List<bool> isSelectedText = [true, false, false, false, false, false];

  int days = 1;
  setDays(String text) {
    setState(() {
      text == 'D'
          ? days = 1
          : text == 'W'
              ? days = 7
              : text == 'M'
                  ? days = 30
                  : text == '3M'
                      ? days = 90
                      : text == '6M'
                          ? days = 180
                          : days = 365;
    });
  }

  List<ChartModel>? itemChart;

// Future là ứng dụng không bị đóng băng nếu thực hiện task lâu.
  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        widget.selectedItem.id +
        '/ohlc?vs_currency=usd&days=' +
        days.toString();

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      //  hàm decode(giải mã) chuyển đổi chuỗi json thành một đối tượng dart là Interable(là một cấu trúc dữ liệu(Có thể lặp) cho phép bạn duyệt qua từng phần tử trong dãy )
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJSON(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
