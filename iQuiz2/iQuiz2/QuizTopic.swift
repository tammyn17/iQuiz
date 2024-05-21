//
//  QuizTopic.swift
//  iQuiz2
//
//  Created by Tammy Nguyen on 5/20/24.
//

import SwiftUI

struct QuizTopic: Identifiable, Codable {
    let id = UUID()
    let title: String
    let desc: String
    let questions: [Question]
    
    static let imageNames: [String: String] = [
        "Science!": "science",
        "Marvel Super Heroes": "marvel",
        "Mathematics": "math"
    ]
    
    var imageName: String {
        return QuizTopic.imageNames[title] ?? "questionmark.circle"
    }
}
