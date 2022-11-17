import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyWidget extends StatefulWidget {
  final Function addT;

  const MyWidget(this.addT, {Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final titleController = TextEditingController();
  DateTime?selectedD;
  final amtController = TextEditingController();

  void sumit() {
    if(amtController.text.isEmpty){
      return;
    }
    final enteredT = titleController.text;
    final enteredA =  double.parse(amtController.text);
    if(enteredT.isEmpty || enteredA<=0|| selectedD == null){
      return;
    }
    widget.addT(enteredT,
        enteredA,selectedD);
        Navigator.of(context).pop();
  }
  void _presenTPicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()).then((picked){
      if(picked== null){
        return;
      }
      setState(() {
        selectedD = picked;
      });
          });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          padding:  EdgeInsets.only(top :10,left:10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom+10,
          ),
          child: Column(children: [
            TextField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_)=>sumit(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amtController,
              onSubmitted: (_)=>sumit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [ Flexible(fit: FlexFit.tight,child: Text(selectedD == null? 'NO DATE CHOSEN!': "Picked date:${DateFormat.yMd().format(selectedD!)}")),
                TextButton(onPressed: (){_presenTPicker();}, child: const Text("CHOOSE DATE"))],
              ),
            ),
            TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 195, 210, 255)),
                ),
                onPressed: sumit,
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(
                      color: Color.fromARGB(255, 64, 78, 120),
                      fontWeight: FontWeight.bold),
                )),
          ]),
        ),
      ),
    );
  }
}
