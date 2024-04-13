import 'package:mentormeister/utils/basic_screen_imports.dart';

import '../../widget/custom_appbar.dart';

class AttemptQuizPage extends StatefulWidget {
  const AttemptQuizPage({super.key});

  @override
  State<AttemptQuizPage> createState() => _AttemptQuizPageState();
}

class _AttemptQuizPageState extends State<AttemptQuizPage> {
  Map<int, String?> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const Center(
          child: CustomAppBar(title: ''),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Attempt Quiz 1',
              style: CustomStyle.interh1,
            ),
            SizedBox(height: Dimensions.heightSize),
            Expanded(
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSize),
                  child: ListView.builder(
                    itemCount: sampleQuestions.length,
                    itemBuilder: (context, index) {
                      final question = sampleQuestions[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q No. ${index + 1}',
                            style: CustomStyle.interh2,
                          ),
                          SizedBox(height: Dimensions.heightSize),
                          Text(
                            question.question,
                            style: CustomStyle.interh2,
                          ),
                          SizedBox(height: Dimensions.heightSize),
                          Column(
                            children: question.options
                                .map(
                                  (option) => RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: selectedOptions[index],
                                    activeColor: Colors.red,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedOptions[index] = value;
                                  });
                                },
                              ),
                            )
                                .toList(),
                          ),
                          SizedBox(height: Dimensions.heightSize),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class QuizQuestion {
  final String question;
  final List<String> options;

  QuizQuestion({
    required this.question,
    required this.options,
  });
}

List<QuizQuestion> sampleQuestions = [
  QuizQuestion(
    question: 'For which purpose is React Native more suitable?',
    options: [
      'For making apps in both Android and iOS',
      'For making web applications',
      'For making desktop applications',
      'For making backend services',
    ],
  ),
  QuizQuestion(
    question: 'What is Flutter known for?',
    options: [
      'Hot reload functionality',
      'Static typing',
      'Native performance',
      'Cross-platform compatibility',
    ],
  ),
  // Add more sample questions as needed
];
