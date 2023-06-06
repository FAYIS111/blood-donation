import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  dynamic valueChoose;
  List listItems = ["A+", "O+", "B+", "AB-", "AB+", "B-"];
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': valueChoose
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add users"),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: donorName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("donar name"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: donorPhone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("phone number"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  width: 1,
                ),
              ),
              child: DropdownButton(
                value: valueChoose,
                onChanged: (newValue) {
                  setState(() {
                    valueChoose = newValue;
                  });
                },
                items: listItems.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: (() {
                addDonor();
                Navigator.pop(context);
              }),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 50)),
              ),
              child: const Text(
                "SUBMIT",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
