import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'data/topic.dart'; // Import for date formatting

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // Replace with your actual data fetching logic
  final List<Topic> topics = [topicFromJson(dataJsonString)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge Bot Topics/Questions'),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final subtopics = topics[index].subtopics;
          return Column(
            children: subtopics
                .map((subtopic) => ExpandableSubtopic(
                      question: subtopic.question,
                      questionDate: subtopic.questionDate,
                      approved: subtopic.approved,
                      possibleAnswers: subtopic.possibleAnswers,
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}

class ExpandableSubtopic extends StatefulWidget {
  final String question;
  final DateTime questionDate;
  final bool approved;
  final List<PossibleAnswer> possibleAnswers;

  const ExpandableSubtopic({
    Key? key,
    required this.question,
    required this.questionDate,
    required this.approved,
    required this.possibleAnswers,
  }) : super(key: key);

  @override
  State<ExpandableSubtopic> createState() => _ExpandableSubtopicState();
}

class _ExpandableSubtopicState extends State<ExpandableSubtopic> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ListTile(
        title: Text(widget.question),
        subtitle: Text(
          DateFormat('yyyy-MM-dd').format(widget.questionDate),
          style: const TextStyle(fontSize: 12),
        ),
        //trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more,),
      ),
      children: [
        AnswerListTile(possibleAnswer: widget.possibleAnswers.first),
        if (_isExpanded)
          for (int i = 1; i < widget.possibleAnswers.length; i++)
            AnswerListTile(possibleAnswer: widget.possibleAnswers[i])
      ],
      onExpansionChanged: (value) => setState(() => _isExpanded = value),
    );
  }
}

class AnswerListTile extends StatelessWidget {
  const AnswerListTile({
    super.key,
    required this.possibleAnswer,
  });

  final PossibleAnswer possibleAnswer;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Text(possibleAnswer.approved ? "Approved" : "Not approved"),
        title: Text(
          possibleAnswer.answer,
          style: TextStyle(
            color: possibleAnswer.approved ? Colors.green : Colors.red,
          ),
        ),
        subtitle: Text(
          DateFormat('yyyy-MM-dd').format(possibleAnswer.date),
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Icon(
          possibleAnswer.approved ? Icons.close : Icons.check,
          color: possibleAnswer.approved ? Colors.red : Colors.green,
        ),
      );
}
