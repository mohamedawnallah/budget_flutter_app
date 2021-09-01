import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart({this.weeklySpendings});
  final List<double> weeklySpendings;

  @override
  Widget build(BuildContext context) {
    double _mostExpensive = 0;
    weeklySpendings.forEach((price) {
      if (price > _mostExpensive) {
        _mostExpensive = price;
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0.5),
      child: Column(
        children: [
          Text(
            "Weekly Spending",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                ),
                iconSize: 20.0,
              ),
              Expanded(
                child: Text(
                  "August 22 , 2021 ->August 29 , 2021",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                ),
                iconSize: 20.0,
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                label: 'Su',
                amountSpent: weeklySpendings[0],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Mo',
                amountSpent: weeklySpendings[1],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Tu',
                amountSpent: weeklySpendings[2],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Th',
                amountSpent: weeklySpendings[3],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'We',
                amountSpent: weeklySpendings[4],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Th',
                amountSpent: weeklySpendings[5],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Fr',
                amountSpent: weeklySpendings[6],
                mostExpensive: _mostExpensive,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({Key key, String label, double amountSpent, double mostExpensive})
      : this.label = label,
        this.amountSpent = amountSpent,
        this.mostExpensive = mostExpensive,
        super(key: key);
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double _maxBarHeight = 150.0;
  @override
  Widget build(BuildContext context) {
    //mostExpensive bar -> the bar with highest spent money
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Text(
            '\$${amountSpent.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Container(
            height: barHeight,
            width: 15.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            label.toString(),
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
