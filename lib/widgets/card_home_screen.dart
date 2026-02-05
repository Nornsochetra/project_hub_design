import 'package:flutter/material.dart';

class CardHomeScreen extends StatelessWidget{
  final String title;
  final String dateText;
  final String status;
  final double progress;

  const CardHomeScreen({
    super.key,
    required this.title,
    required this.dateText,
    required this.progress,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();
    return SizedBox(
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
                title,
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
                    dateText,
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
                    status,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        color: Colors.grey
                    ),
                  )
                  ),
                  Text(
                    dateText,
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
    );
  }
}