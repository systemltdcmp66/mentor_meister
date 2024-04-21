import 'package:mentormeister/features/Teacher/presentation/widgets/live_session_start.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';

import '../../../../models/upcoming_session_model.dart';
import '../../../../commons/widgets/custom_appbar.dart';

class LiveSessionPage extends StatelessWidget {
  const LiveSessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: CustomAppBar(
          title: 'Live Session',
          centerTitle: true,
          onBookmarkPressed: () {},
          icon: Icons.bookmark_added_outlined,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: upcomingSessions.length,
          itemBuilder: (BuildContext context, int index) {
            return buildLiveSessionCard(upcomingSessions[index], () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VideoCallScreen()));
            });
          },
        ),
      ),
    );
  }

  Widget buildLiveSessionCard(UpcomingSession session, VoidCallback onPressed) {
    bool isCleared = false;
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage(
                        'assets/teacher/person.png'), // Placeholder image
                    radius: 20.r,
                  ),
                  SizedBox(width: Dimensions.widthSize),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.studentName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('Student'),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Handle pending button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCleared
                          ? const Color(0xff6daa6c).withOpacity(0.74)
                          : const Color(0xfffcdddd),
                    ),
                    child: Text(
                      isCleared ? 'Cleared' : 'Pending',
                      style: const TextStyle(color: CustomColor.redColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Row 2: Course Title
              Text(
                session.courseTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Row 3: Clock Icon, Timing, and Duration (red color)
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Colors.red, // Red color for icon
                  ),
                  const SizedBox(width: 4),
                  Text(
                    session.time,
                    style: const TextStyle(
                        color: Colors.red), // Red color for text
                  ),
                  Text(
                    ' ${session.duration}',
                    style: const TextStyle(
                        color: Colors.red), // Red color for text
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
