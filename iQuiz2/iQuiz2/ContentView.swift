//
//  ContentView.swift
//  iQuiz2
//
//  Created by Tammy Nguyen on 5/20/24.
//

import SwiftUI

struct ContentView: View {
    @State var showingSettings = false
    @State var newURL = "https://tednewardsandbox.site44.com/questions.json"
    @State var quizTopics: [QuizTopic] = []
    @State var alertMessage = ""
    @State var timer: Timer?
    @State var refreshInterval: TimeInterval = 90.0
    
    var body: some View {
        NavigationView {
            List(quizTopics) { topic in
                NavigationLink(destination: QuestionListView(topic: topic)) {
                    QuizTopicRow(topic: topic)
                }
            }
            .listStyle(PlainListStyle()) // Use plain list style
            .navigationBarTitle("iQuiz", displayMode: .inline)
            .navigationBarItems(leading:
                                    NavigationLink(destination: SettingsView(newURL: $newURL, refreshInterval: $refreshInterval)) {
                Text("Settings")
            }
            )
            .onAppear {
                getData(from: newURL)
                setupTimer()
            }
            .alert(isPresented: Binding<Bool>(
                get: { alertMessage != "" },
                set: { _,_ in }
            )) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .refreshable {
                getData(from: newURL)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getData(from url: String) {
        guard let url = URL(string: url) else {
            alertMessage = "Invalid URL"
            return
        }
        
        if !Reachability.isConnectedToNetwork() {
            alertMessage = "Network is not available"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let quizData = try decoder.decode([QuizTopic].self, from: data)
                    DispatchQueue.main.async {
                        self.quizTopics = quizData
                        UserDefaults.standard.set(url.absoluteString, forKey: "quizDataURL")
                    }
                } catch {
                    DispatchQueue.main.async {
                        alertMessage = "Error decoding JSON: \(error.localizedDescription)"
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Error fetching data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func setupTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true) { _ in
            getData(from: newURL)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct QuizTopicRow: View {
    let topic: QuizTopic
    
    var body: some View {
        HStack {
            Image(topic.imageName)
                .resizable()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(topic.title)
                    .font(.headline)
                Text(topic.desc)
                    .font(.subheadline)
            }
        }
    }
}

struct Reachability {
    static func isConnectedToNetwork() -> Bool {
        return true
    }
}
