import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';

class FeedbackCard extends StatelessWidget {
  final String username;
  final String userImage;
  final String feedbackStatus;
  final String feedbackMessage;
  final bool isAnon;

  FeedbackCard(
      {required this.username,
      required this.userImage,
      required this.feedbackStatus,
      required this.feedbackMessage,
      required this.isAnon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: isAnon
                      ? AssetImage(ImagePath.getImagePath(
                          ScreenName.landing, "anon.jpg"))
                      : NetworkImage(userImage) as ImageProvider,
                  radius: 20,
                ),
                SizedBox(width: 8),
                Text(
                  isAnon ? "Anonymous" : username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '$feedbackStatus',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getStatusColor(feedbackStatus),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$feedbackMessage',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'positive':
        return Colors.green;
      case 'negative':
        return Colors.red;
      case 'neutral':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}
