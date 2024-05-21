//
//  SettingsView.swift
//  iQuiz2
//
//  Created by Tammy Nguyen on 5/20/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var newURL: String
    @Binding var refreshInterval: TimeInterval
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .padding(.top, 10)
            Spacer()
            VStack(alignment: .leading) {
                Text("URL:")
                    .font(.headline)
                    .padding(.top)
                TextField("Enter URL", text: $newURL)
            }
            .padding(.horizontal)
            VStack(alignment: .leading) {
                Text("Refresh(seconds):")
                    .font(.headline)
                    .padding(.top)
                TextField("Enter seconds", value: $refreshInterval, formatter: NumberFormatter())
            }
            .padding(.horizontal)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    UserDefaults.standard.set(newURL, forKey: "quizDataURL")
                }) {
                    Text("Check Now")
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding(.top)
            }
        }
        .padding()
    }
}
