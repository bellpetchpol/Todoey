//
//  ViewController.swift
//  Todoey
//
//  Created by bigbell_MacPro2018 on 1/20/18.
//  Copyright © 2018 TochsapornP. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //loadItems()

    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == false {
            
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
                itemArray[indexPath.row].done = false
                
            } else {
                
                cell.accessoryType = .checkmark
                itemArray[indexPath.row].done = true
                
            }
            saveItems()
        }
    }

    //MARK - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen when user click Add Item Button on UiAlert
            //let item = Item()
            
            
            let item = Item(context: self.context)
            
            item.title = textField.text!
            item.done = false

            self.itemArray.append(item)
            
            self.saveItems()
            
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
    
    func saveItems() {
 
        do {
            try context.save()
        } catch {
            print("Error encoding item array, \(error)")
        }
        
    }
    
//    func loadItems() {
//
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error docoding tem array \(error)")
//            }
//        } else {
//            let item = Item()
//            let item2 = Item()
//            let item3 = Item()
//            item.title = "Find Mike"
//            item.done = false
//            itemArray.append(item)
//
//            item2.title = "Try cocacola"
//            item2.done = false
//            itemArray.append(item2)
//
//            item3.title = "Try Kooi"
//            item3.done = false
//            itemArray.append(item3)
//        }
//    }
    

}

