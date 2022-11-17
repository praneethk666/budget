import 'package:flutter/material.dart';

class Cbar extends StatelessWidget {
  final String label;
  final double spendingAmt;
  final double spendingAmtTotal;
  Cbar(this.label, this.spendingAmt, this.spendingAmtTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (c,constraints){
      return Column(
      children: <Widget>[
        Container(
            height: constraints.maxHeight*0.15,
            child:
                FittedBox(child: Text('₹${spendingAmt.toStringAsFixed(0)}'))),
         SizedBox(
          height: constraints.maxHeight*0.05,
        ),
        Container(
          height:  constraints.maxHeight*0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(129, 255, 255, 255), width: 1.0),
                  color: const Color.fromARGB(255, 27, 25, 25),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingAmtTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
         SizedBox(
          height:  constraints.maxHeight*0.05,
        ),
        Container(height:  constraints.maxHeight*0.15,child: FittedBox(child: Text(label))),
      ],
    );
    });
    
  }
}
