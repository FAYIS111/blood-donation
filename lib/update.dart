import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  dynamic valueChoose;
  List listItems = ["A+", "O+", "B+", "AB-", "AB+", "B-"];
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void updateDonor(docId) {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': valueChoose,
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    valueChoose = args['group'];
    final docId = args["id"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update users"),
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
                updateDonor(docId);
              }),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 50)),
              ),
              child: const Text(
                "UPDATE",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
