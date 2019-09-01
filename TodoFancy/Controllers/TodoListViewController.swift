//
//  ViewController.swift
//  TodoFancy
//
//  Created by useradmin on 29/08/19.
//  Copyright © 2019 Faishal Murtadho. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let TO_DO_LIST_ARRAY : String = "ToDoListArray"
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: TO_DO_LIST_ARRAY) as? [Item] {
            itemArray = items
        }
        
        let newItem = Item()
        newItem.title = "Find the Ring"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Kill Sauron"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Ride Nazgul"
        itemArray.append(newItem3)
    }
    
    // MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Task To Do", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: self.TO_DO_LIST_ARRAY)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    


}

