import 'package:flutter/material.dart';
import 'package:ui_demo/models/employee.dart';
import 'package:ui_demo/services/employee_operations.dart';

class EditEmployee extends StatelessWidget {
  final Employee employee;
  EditEmployee({this.employee});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = employee.name;
    postController.text = employee.post;
    salaryController.text = employee.salary.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Employee'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: postController,
              decoration: InputDecoration(hintText: 'Post'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(hintText: 'Salary'),
            ),
            SizedBox(height: 16),
            RaisedButton(
              child: Text('Edit Employee'),
              onPressed: (){
                editingEmployee(context);
              },
            )
          ],
        ));
  }

  void editingEmployee(BuildContext context) async {
    String n = nameController.text;
    String p = postController.text;
    int s = int.parse(salaryController.text);

    Employee e = Employee(id: employee.id, name: n, post: p, salary: s);

    await EmployeeOperations.instance.updateEmployee(e);
    Navigator.pop(context);
  }
}
