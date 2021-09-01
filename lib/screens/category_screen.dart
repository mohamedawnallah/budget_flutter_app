import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';
import '../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  const CategoryScreen({Key key, Category category})
      : this.category = category,
        super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Widget> _buildExpenses() {
    List<Widget> expenseList = [];
    widget.category.expenses.forEach(
      (expense) {
        expenseList.add(
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(expense.name,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Text("-\$${expense.cost.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Colors.red[300],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600))
              ],
            ),
          ),
        );
      },
    );
    return expenseList;
  }

  @override
  Widget build(BuildContext context) {
    double _totalAmountSpent = 0;
    widget.category.expenses.forEach((expense) {
      _totalAmountSpent += expense.cost;
    });
    final double amountLeft = widget.category.maxAmount - _totalAmountSpent;
    final double percent = amountLeft / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
          iconSize: 20,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15.0,
                ),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)}/ \$${widget.category.maxAmount}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            ..._buildExpenses()
          ],
        ),
      ),
    );
  }
}
