//
//  ViewController.swift
//  Todoey
//
//  Created by bigbell_MacPro2018 on 1/20/18.
//  Copyright © 2018 TochsapornP. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Try cocacola","Try Kooi"]
    var checkedArray = [false,false,false]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
        if let items = defaults.array(forKey: "CheckedListArray") as? [Bool]{
            checkedArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        if checkedArray[indexPath.row] == false {
            
            cell.accessoryType = .none
            
        } else {
            
            cell.accessoryType = .checkmark
            
        }
        
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath){
            
            if cell.accessoryType == .checkmark {
                
                cell.accessoryType = .none
                checkedArray[indexPath.row] = false
                
            } else {
                
                cell.accessoryType = .checkmark
                checkedArray[indexPath.row] = true
                
            }
            saveUserdefaultsData()
        }
    }

    //MARK - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen when user click Add Item Button on UiAlert
            
            self.itemArray.append(textField.text!)
            self.checkedArray.append(false)
            
            self.saveUserdefaultsData()
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Save Userdefaults data
    
    func saveUserdefaultsData() {
        // save data to userdefault
        self.defaults.set(self.itemArray, forKey: "TodoListArray")
        self.defaults.set(self.checkedArray, forKey: "CheckedListArray")
    }
    

}

