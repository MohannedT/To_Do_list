//
//  TasksTableViewController.swift
//  ToDo
//
//  Created by MOHANNED on 03/10/2020.
//  Copyright © 2020 MOHANNED. All rights reserved.
//

import UIKit
import RealmSwift

class TasksTableViewController: UITableViewController {
    
    //let realm = try! Realm()
    var tasks: Results<Task>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = realm.objects(Task.self)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.count != 0 {
            return tasks.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row].name
        
        return cell
    }
    
    
    @IBAction func addTask(_ sender: Any) {
        createAlertController()
    }
    
    
    func createAlertController() {
        
        let alert = UIAlertController(title: "INSERT YOUR DATA", message: "", preferredStyle: .alert)
        
        var alertTextField: UITextField!
        alert.addTextField { (textField) in
            alertTextField = textField
            textField.placeholder = "put your text"
        }
        
        let saveButton = UIAlertAction(title: "SAVE", style: .default) { (action) in
            guard let text = alertTextField.text, !text.isEmpty else { return }
            let task = Task()
            task.name = text
            
            //            try! self.realm.write {
            //                self.realm.add(task)
            //            }
            
            StorageManager.saveTasksList(task)
            
            self.tableView.insertRows(at: [IndexPath.init(row: self.tasks.count - 1, section: 0)], with: .automatic)
        }
        
        let cancelButton = UIAlertAction(title: "EXIT", style: .cancel)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editingRow = tasks[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteTasks(editingRow)
            
            //            try! self.realm.write {
            //                self.realm.delete(editingRow)
            //                tableView.reloadData()
            //            }
            
            tableView.reloadData()
        }
        
        return [deleteAction]
    }
}
