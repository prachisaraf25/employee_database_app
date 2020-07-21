import 'package:flutter/material.dart';
import 'package:ui_demo/models/employee.dart';
import 'package:ui_demo/screens/add_employee.dart';
import 'package:ui_demo/screens/edit_employee.dart';
import 'package:ui_demo/services/employee_operations.dart';
import 'package:ui_demo/services/jump_to_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employeeList = [];

  EmployeeOperations employeeOperations = EmployeeOperations.instance;

  void getData() async {
    List<Employee> e = await employeeOperations.getAllEmployees();

    setState(() {
      employeeList = e;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Data')),
      body: employeeList.length == 0
          ? NoText()
          : GetEmployee(employeeList: employeeList),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await JumpToPage.push(
            context,
            AddEmployee(),
          );

          getData();
        },
      ),
    );
  }
}

class NoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Employee'),
    );
  }
}

class GetEmployee extends StatefulWidget {
  List<Employee> employeeList;
  GetEmployee({this.employeeList});

  @override
  _GetEmployeeState createState() => _GetEmployeeState();
}

class _GetEmployeeState extends State<GetEmployee> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.employeeList.length,
      itemBuilder: (BuildContext context, int index) {
        Employee employee = widget.employeeList[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(employee.name[0]),
          ),
          title: Text(employee.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(employee.post),
              Text(employee.salary.toString()),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              deleteEmployee(context, employee);
            },
          ),
          onTap: () async {
            await JumpToPage.push(
              context,
              EditEmployee(
                employee: employee,
              ),
            );
            List<Employee> e =
                await EmployeeOperations.instance.getAllEmployees();
            setState(() {
              widget.employeeList = e;
            });
          },
        );
      },
    );
  }

  void deleteEmployee(BuildContext context, Employee employee) async {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Alert!!!!'),
      content: Text('Do you want to delete ${employee.name}?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () async {
            await EmployeeOperations.instance.deleteEmployee(employee);
            List<Employee> e =
                await EmployeeOperations.instance.getAllEmployees();

            setState(() {
              widget.employeeList = e;
            });
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () async {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
