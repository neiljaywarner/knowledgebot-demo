// To parse this JSON data, do
//
//     final topic = topicFromJson(jsonString);

import 'dart:convert';

Topic topicFromJson(String str) => Topic.fromJson(json.decode(str));

String topicToJson(Topic data) => json.encode(data.toJson());

class Topic {
  String topic;
  List<Subtopic> subtopics;

  Topic({
    required this.topic,
    required this.subtopics,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        topic: json["topic"],
        subtopics: List<Subtopic>.from(json["subtopics"].map((x) => Subtopic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topic": topic,
        "subtopics": List<dynamic>.from(subtopics.map((x) => x.toJson())),
      };
}

class Subtopic {
  String question;
  DateTime questionDate;
  bool approved;
  List<PossibleAnswer> possibleAnswers;

  Subtopic({
    required this.question,
    required this.questionDate,
    required this.approved,
    required this.possibleAnswers,
  });

  factory Subtopic.fromJson(Map<String, dynamic> json) => Subtopic(
        question: json["question"],
        questionDate: DateTime.parse(json["question_date"]),
        approved: json["approved"],
        possibleAnswers: List<PossibleAnswer>.from(
            json["possible_answers"].map((x) => PossibleAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "question_date": questionDate.toIso8601String(),
        "approved": approved,
        "possible_answers": List<dynamic>.from(possibleAnswers.map((x) => x.toJson())),
      };
}

class PossibleAnswer {
  String answer;
  DateTime date;
  bool approved;

  PossibleAnswer({
    required this.answer,
    required this.date,
    required this.approved,
  });

  factory PossibleAnswer.fromJson(Map<String, dynamic> json) => PossibleAnswer(
        answer: json["answer"],
        date: DateTime.parse(json["date"]),
        approved: json["approved"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "date": date.toIso8601String(),
        "approved": approved,
      };
}

const dataJsonString = '''


{
  "topic": "The Future of Work",
  "subtopics": [
    {
      "question": "What skills will be most important in the future workforce?",
      "question_date": "2024-07-20T00:00:00.000Z",
      "approved": false,
      "possible_answers": [
        {
          "answer": "Technical skills (e.g., coding, data analysis)",
          "date": "2024-07-20T00:00:00.000Z",
          "approved": false
        },
        {
          "answer": "Soft skills (e.g., communication, teamwork, critical thinking)",
          "date": "2024-07-20T00:00:00.000Z",
          "approved": false
        },
        {
          "answer": "Adaptability and lifelong learning",
          "date": "2024-07-20T00:00:00.000Z",
          "approved": false
        }
      ]
    },
    {
      "question": "How will automation and AI change the types of jobs available?",
      "question_date": "2024-07-20T00:00:00.000Z",
      "approved": false,
      "possible_answers": [
        {
          "answer":         "Job displacement in certain sectors",
          "date": "2024-07-20T00:00:00.000Z",
          "approved": true
        },
        {
          "answer":        "Creation of new jobs in areas like AI development and maintenance",
          "date": "2024-07-20T00:00:00.000Z",
          "approved": false
        },
        {
          "answer":         "Increased need for human-AI collaboration",
          "date": "2024-07-20T00:00:00.000Z",
          "approved": false
        }
      ]
    }
  ]
}


''';
