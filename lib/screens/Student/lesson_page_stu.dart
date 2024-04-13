//import 'package:audioplayers/audioplayers.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

class AudioLesson {
  final String title;
  final String audioUrl;

  AudioLesson({required this.title, required this.audioUrl});
}

class LessonsPageStudent extends StatefulWidget {
  const LessonsPageStudent({Key? key}) : super(key: key);

  @override
  _LessonsPageStudentState createState() => _LessonsPageStudentState();
}

class _LessonsPageStudentState extends State<LessonsPageStudent> {
  List<AudioLesson> audioLessons = [
    AudioLesson(title: 'Lesson 1', audioUrl: 'ambient_c_motion.mp3'),
    AudioLesson(title: 'Lesson 2', audioUrl: 'ambient_c_motion.mp3'),
    // Add more audio lessons as needed
  ];
  Duration? _duration;
  Duration? _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: audioLessons.length,
        itemBuilder: (context, index) {
          return _buildLessonCard(context, audioLessons[index]);
        },
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, AudioLesson lesson) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.paddingSize, right: Dimensions.paddingSize),

      child: Column(
        children: [
          Card(
            elevation: 0,
            color: const Color(0xfff7e4e6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: CustomColor.redColor,
                      child: Icon(Icons.play_arrow, color: CustomColor.whiteColor,),
                    ),
                    onPressed: () {}
                  ),
                  title: Text(lesson.title),
                  subtitle: LinearProgressIndicator(
                    color: CustomColor.redColor,
                    backgroundColor: CustomColor.whiteColor,
                    minHeight: 8.h,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    value: _position != null && _duration != null
                        ? _position!.inMilliseconds / _duration!.inMilliseconds
                        : 0.3,
                  ),
                  trailing: Text(_getAudioTime()),
                  onTap: () {
                    // Handle tapping on the lesson
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getAudioTime() {
    if (_position != null && _duration != null) {
      int seconds = _position!.inSeconds;
      int minutes = (seconds ~/ 60) % 60;
      int remainingSeconds = seconds % 60;
      return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return '00:00';
    }
  }
}
