import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hub_design/models/project.dart';
import 'package:project_hub_design/screens/details_screen/card_detail_screens.dart';

class CardHomeScreen extends StatelessWidget{
  final Project project;
  final VoidCallback? onDelete;

  const CardHomeScreen({
    super.key,
    required this.project,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (project.progress * 100).round();
    var monthDayFormat = DateFormat('MMM dd').format(project.dateTime);
    var yearMonthDayFormat = DateFormat('yyyy MMM dd').format(project.dateTime);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
          MaterialPageRoute(
              builder: (_) => CardDetailScreens(
                project: project,
                onDelete: onDelete,
              ),
          ),
        );
      },
      child: SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 2.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,// Use minimum space
                children: <Widget>[
                  Text(
                    project.title,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),

                  Row(
                    children: [
                      Expanded(
                        child: Text('${
                            percent.toString()} %',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: .w600,
                              color: Colors.grey
                          ),
                        ),
                      ),
                      Text(
                        monthDayFormat,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 4),

                  Row(
                    children: [
                      // SizedBox(
                      //   width: 22,
                      //   height: 22,
                      //   child: CircularProgressIndicator(
                      //     value: percent / 100, // if percent is 0-100
                      //     strokeWidth: 3,
                      //   ),
                      // ),
                      // const SizedBox(width: 10),
                      Expanded(child:
                      Text(
                        statusToText(project.status),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: .w400,
                            color: Colors.grey
                        ),
                      )
                      ),
                      Text(
                        yearMonthDayFormat,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: .w400,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}