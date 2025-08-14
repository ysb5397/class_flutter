import 'package:cloud_rest/helper/Cloud_helper.dart';
import 'package:flutter/material.dart';

class RecruitList extends StatefulWidget {
  const RecruitList({super.key});

  @override
  State<RecruitList> createState() => _RecruitListState();
}

class _RecruitListState extends State<RecruitList> {
  List<Map<String, dynamic>> recruitData = [];

  @override
  Widget build(BuildContext context) {
    CloudHelper.getApplies().then((onValue) => {
          {
            onValue["content"].forEach((value) => {
                  recruitData.add({
                    "recruitId": value["recruitId"],
                    "title": value["title"],
                    "content": value["content"],
                    "deadline": value["deadline"],
                    "createdAt": value["createdAt"]
                  })
                })
          }
        });
    return ListView.builder(
      itemCount: recruitData.length,
      itemBuilder: (context, index) {
        final recruit = recruitData[index];
        return _buildRecruitList(recruit);
      },
    );
  }

  Widget _buildRecruitList(recruit) {
    final id = recruit["recruitId"] as int;
    final title = recruit["title"] as String;
    final content = recruit["content"] as String;
    final deadline = recruit["deadline"] as String;
    final createdAt = recruit["createdAt"] as String;

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        elevation: 2,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Text(title),
                  Text(createdAt),
                  Text("아이디: $id"),
                ],
              ),
              Text(content),
              Text(deadline),
            ],
          ),
        ));
  }
}
