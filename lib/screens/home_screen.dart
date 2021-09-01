import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/models/models.dart';
import 'package:flutter_budget_ui/screens/screens.dart';
import 'package:flutter_budget_ui/widgets/widgets.dart';
export 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryScreen(
            category: category,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = maxBarWidth * percent;
                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  final GlobalKey _containerKey = GlobalKey();
  Size _containerSize;
  Offset _containerOffset;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => getSizeAndPosition());
  }

  getSizeAndPosition() {
    RenderBox _containerBox = _containerKey.currentContext.findRenderObject();
    _containerSize = _containerBox.size;
    _containerOffset = _containerBox.localToGlobal(Offset.zero);
    print(_containerSize);
    print(_containerOffset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
            leading: IconButton(
              icon: Icon(Icons.paid),
              iconSize: 30.0,
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("Weekly Budget",
                  style: TextStyle(
                    fontSize: 14.0,
                  )),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 30.0,
                onPressed: () {},
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Container(
                    key: _containerKey,
                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarChart(weeklySpendings: weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double _totalAmountSpent = 0;
                  category.expenses.forEach((Expense expense) {
                    _totalAmountSpent += expense.cost;
                  });
                  return _buildCategory(category, _totalAmountSpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          )
        ],
      ),
    );
  }
}
