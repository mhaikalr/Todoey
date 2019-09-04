//
//  ViewController.swift
//  Todoey
//
//  Created by Haikal on 3/9/19.
//  Copyright © 2019 Haikal Rosman. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let DATA_FILE_PATH = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        
    }
    
    //MARK - tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let currentItem = itemArray[indexPath.row]
        
        cell.textLabel?.text = currentItem.title
        
        cell.accessoryType = (currentItem.isDone) ? .checkmark : .none
        
        return cell
    }
    
    //MARK - tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
        
        let currentItem = itemArray[indexPath.row]
        
        currentItem.isDone = !currentItem.isDone
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen when users clicks add item
            
            let textToAdd = textField.text!
            if textToAdd != "" {
                self.itemArray.append(Item(title: textToAdd))
                self.saveData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type in your item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveData() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: DATA_FILE_PATH!)
        }
        catch {
            print("Error encoding, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        
        let decoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: DATA_FILE_PATH!) {
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error decoding, \(error)")
            }
        }
    }
    
}

