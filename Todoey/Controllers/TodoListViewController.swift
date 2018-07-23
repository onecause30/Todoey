//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Hall on 7/19/18.
//  Copyright © 2018 Anthony Hall. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plis")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
       
       
        
        
        
        
        
        
        loadItems()
        
        //  if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
          //  itemArray = items
       // }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = item.title
         //ternary operator ==>
        // value = condition ? valueIFTrue : valueIfFalse
        cell.accessoryType = item.done  ? .checkmark : .none
       
        return cell 
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      saveItems()
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
       
        
        let newItem = Item()
        newItem.title = textField.text!
     self.itemArray.append(newItem)
      
        self.saveItems()
        
      
        
        
    }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = " Create new item"
            textField = alertTextField
           
            
        }
    alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
}
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
            do {
          itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
                
            }
}
}
}
