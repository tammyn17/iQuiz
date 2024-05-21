//
//  AnswerView.swift
//  iQuiz2
//
//  Created by Tammy Nguyen on 5/20/24.
//

import SwiftUI

struct AnswerView: View {
    let question: Question
    let correctAnswer: String
    let userAnswer: String?
    let dismissAction: () -> Void
    
    var body: some View {
        VStack {
            Text(question.text)
                .padding()
                .font(.title)
            Text("Correct Answer: \(correctAnswer)")
                .padding()
                .font(.body)
            Text("Your Answer: \(userAnswer ?? "")")
                .padding()
                .font(.body)
            Spacer()
            HStack {
                Spacer()
                Button("Next") {
                    dismissAction()
                }
                .padding()
                .foregroundColor(.blue)
                .padding()
            }
        }
    }
}
