//
//  Question.swift
//  iQuiz2
//
//  Created by Tammy Nguyen on 5/20/24.
//

import SwiftUI

struct Question: Codable {
    let text: String
    let answer: String
    let answers: [String]
}
