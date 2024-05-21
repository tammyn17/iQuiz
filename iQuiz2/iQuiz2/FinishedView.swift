//
//  FinishedView.swift
//  iQuiz2
//
//  Created by Tammy Nguyen on 5/20/24.
//

import SwiftUI

struct FinishedView: View {
    let score: Int
    let totalQuestions: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    var scoreText: String {
        let percentage = Double(score) / Double(totalQuestions)
        switch percentage {
        case 1.0:
            return "Perfect!"
        case 0.0..<1.0:
            return "More Studying!"
        default:
            return "No Score"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(scoreText)
                .font(.title)
                .padding()
            Text("Score:")
                .font(.body)
                .padding(.bottom, 5)
            HStack {
                Text("\(score)")
                    .font(.headline)
                Text("out of")
                    .font(.body)
                Text("\(totalQuestions)")
                    .font(.headline)
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Next")
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .padding()
        }
    }
}
