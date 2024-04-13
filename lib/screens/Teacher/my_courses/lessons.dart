import 'package:mentormeister/utils/basic_screen_imports.dart';

class AudioLesson {
  final String title;
  final String audioUrl;

  AudioLesson({required this.title, required this.audioUrl});
}

class LessonsPage extends StatefulWidget {

  const LessonsPage({Key? key}) : super(key: key);

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  //late AudioPlayer audioPlayer;
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
            color: const Color(0xfffcdddd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: CustomColor.redColor,
                      child: Icon(Icons.play_arrow, color: CustomColor.whiteColor,),
                    ),
                    onPressed: (){}
                   // => _playAudio(lesson.audioUrl),
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
                const SizedBox(height: 8), // Add spacing between ListTile and buttons

              ],
            ),
          ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle edit button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Edit', style: CustomStyle.whiteh3,),
                ),
                SizedBox(width: Dimensions.widthSize,),
                ElevatedButton(
                  onPressed: () {
                    // Handle delete button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Delete', style: CustomStyle.whiteh3,),
                ),
              ],
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
