import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';

class NameEdit extends StatefulWidget {
  const NameEdit({super.key});

  @override
  State<NameEdit> createState() => _NameEditState();
}

class _NameEditState extends State<NameEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      height: 300,
      width: 330,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
      child: Column(
        
        children: [

tx600("Edit Profile"),
height(30),
Container(
  alignment: Alignment.centerLeft,
  child: tx500("Enter update name *",size: 15),
),
height(10),
Container(
  height: 50,
  padding: EdgeInsets.only(left: 10,),
  alignment: Alignment.centerLeft,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(.4))),
  child: TextField(decoration: InputDecoration(
    border: InputBorder.none,
    isCollapsed: true,
    isDense: true,
    hintText: "eg : John"
  ),),
),
height(30),
ButtonContainer(tx600("Update",color: Colors.white), width: 200, radius: 10, )
        ],
      ),
    );
  }
}