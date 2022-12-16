import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final dayLabel;
  final dayAmount;
  final double amountPctOfTotal;
  ChartBar(this.dayLabel, this.dayAmount, this.amountPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Container(
            height: constraint.maxHeight * 0.13,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '\$${dayAmount.toStringAsFixed(0)}',
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 8,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: amountPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(height: constraint.maxHeight * 0.17, child: Text(dayLabel)),
        ],
      );
    });
  }
}
