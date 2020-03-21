import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:registration/associateData.dart';
import 'package:registration/widgets/associateList.dart';

class AssociateListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AssociateData>(context, listen: false).getAssociates();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 16.0,
        title: Text(
          'Associates',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: AssociateList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/AddAssociatePage');
        },
      ),
    );
  }
}
