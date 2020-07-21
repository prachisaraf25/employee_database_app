import 'package:flutter/material.dart';
import 'package:ui_demo/models/employee.dart';
import 'package:ui_demo/services/employee_operations.dart';

class AddEmployee extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Employee')),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: postController,
              decoration: InputDecoration(
                hintText: 'Post',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(
                hintText: 'Salary',
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              child: Text('Add Employee'),
              onPressed: () {
                addingEmployee(context);
              },
            )
          ],
        ));
  }

  void addingEmployee(BuildContext context) async {
    String n = nameController.text;
    String p = postController.text;
    int s = int.parse(salaryController.text);

    Employee e = Employee(name: n, post: p, salary: s);

    await EmployeeOperations.instance.addEmployee(e);
    Navigator.pop(context);
  }
}
