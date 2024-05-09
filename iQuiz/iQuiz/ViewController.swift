//
//  ViewController.swift
//  iQuiz
//
//  Created by Tammy Nguyen on 5/3/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var settings: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    
    let quizTopics = [
        ["title": "Mathematics", "desc": "Test your math skills!", "icon": "math"],
        ["title": "Marvel Super Heroes", "desc": "Do you know your heroes?", "icon": "marvel"],
        ["title": "Science", "desc": "Explore your scientific skills!", "icon": "science"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        let topic = quizTopics[indexPath.row]
        cell.title.text = topic["title"]
        cell.desc.text = topic["desc"]
        cell.icon.image = UIImage(named: topic["icon"] ?? "")

        return cell
    }

    @IBAction func tapSettings() {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
