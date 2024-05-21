//
//  QuestionView.swift
//  iQuiz2
//
//  Created by Tammy Nguyen on 5/20/24.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    let didSelectAnswerIndex: (Int) -> Void
    @State var selectedAnswerIndex: Int?
    
    var body: some View {
        VStack {
            Text(question.text)
                .font(.title)
                .padding()
            ForEach(question.answers.indices, id: \.self) { index in
                Button(action: {
                    selectedAnswerIndex = index
                }) {
                    HStack {
                        Text(question.answers[index])
                            .foregroundColor(selectedAnswerIndex == index ? .blue : .black)
                        Spacer()
                        if selectedAnswerIndex == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(selectedAnswerIndex == index ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            Spacer()
            if selectedAnswerIndex != nil {
                HStack {
                    Spacer()
                    Button(action: {
                        if let selectedAnswerIndex = selectedAnswerIndex {
                            didSelectAnswerIndex(selectedAnswerIndex)
                        }
                    }) {
                        Text("Submit")
                            .padding()
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
            }
        }
    }
}

struct QuestionListView: View {
    let topic: QuizTopic
    @State var currentQuestionIndex = 0
    @State var userAnswers: [String?] = []
    @State var isAnswerViewPresented = false
    @State var userScore = 0
    
    var totalQuestions: Int {
        topic.questions.count
    }
    
    var currentQuestion: Question {
        topic.questions[currentQuestionIndex]
    }
    
    var body: some View {
        VStack {
            if currentQuestionIndex < topic.questions.count {
                if isAnswerViewPresented {
                    AnswerView(question: currentQuestion, correctAnswer: currentQuestion.answers[Int(currentQuestion.answer)! - 1], userAnswer: userAnswers[currentQuestionIndex], dismissAction: {
                        isAnswerViewPresented = false
                        currentQuestionIndex += 1
                    })
                } else {
                    QuestionView(question: currentQuestion, didSelectAnswerIndex: { answerIndex in
                        let userAnswer = currentQuestion.answers[answerIndex]
                        userAnswers.append(userAnswer)
                        if userAnswer == currentQuestion.answers[Int(currentQuestion.answer)! - 1] {
                            userScore += 1
                        }
                        isAnswerViewPresented = true
                    })
                }
            } else {
                FinishedView(score: userScore, totalQuestions: totalQuestions)
            }
        }
    }
}
