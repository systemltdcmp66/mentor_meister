import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import '../../commons/widgets/custom_appbar.dart';
import '../Student/meeting_report_page.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool isFpSpeaking = false;
  bool isSpSpeaking = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: CustomAppBar(
          title: 'Live Session',
          includeBookmarkIcon: true,
          onBookmarkPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Stream Videos of ongoing calls here
            Stack(
              children: [
                Container(
                  foregroundDecoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/teacher/v1.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  padding: EdgeInsets.all(Dimensions.paddingSize),
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: null,
                ),
                if (isFpSpeaking)
                  Positioned(
                    top: 15.h,
                    left: 10.h,
                    child: Container(
                      padding: EdgeInsets.all(5.r),
                      color: Colors.blue,
                      child: const Icon(Icons.multitrack_audio,
                          color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(height: Dimensions.heightSize),
            // Video of person 2
            Stack(children: [
              Container(
                padding: EdgeInsets.all(Dimensions.paddingSize),
                foregroundDecoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/teacher/v2.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white,
                ),
                child: null,
              ),
              if (isSpSpeaking)
                Positioned(
                  top: 15.h,
                  left: 10.h,
                  child: Container(
                    padding: EdgeInsets.all(5.r),
                    color: Colors.blue,
                    child:
                        const Icon(Icons.multitrack_audio, color: Colors.white),
                  ),
                ),
            ]),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Recording button
                    icon(Icons.mic_rounded, () {}, Colors.grey, Colors.black),
                    // Sound button
                    icon(Icons.volume_up, () {}, Colors.grey, Colors.black),
                    // Live button
                    icon(Icons.emergency_recording, () {}, Colors.grey,
                        Colors.black),
                    // Message button
                    icon(Icons.message, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MeetingReportPage()));
                    }, Colors.blue, Colors.white),
                    // Close button
                    icon(Icons.close, () {
                      Navigator.pop(context);
                    }, Colors.red, Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget icon(
      IconData icon, VoidCallback onPressed, Color bgColor, Color iconColor) {
    return CircleAvatar(
      backgroundColor: bgColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
      ),
    );
  }
}
