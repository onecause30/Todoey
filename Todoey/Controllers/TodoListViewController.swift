//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Hall on 7/19/18.
//  Copyright © 2018 Anthony Hall. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController  {
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
           loadItems()
        }
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
       
       
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       
        
        
        
        
        //  if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
          //  itemArray = items
       // }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
        
        
        
        cell.textLabel?.text = item.title
         //ternary operator ==>
        // value = condition ? valueIFTrue : valueIfFalse
        cell.accessoryType = item.done  ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items Added"
        }
        return cell 
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                
               item.done = !item.done
            }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        
    
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        if let currentCategory = self.selectedCategory {
            do {
            try self.realm.write {
                let newItem = Item()
                newItem.title = textField.text!
                newItem.dateCreated = Date()
                currentCategory.items.append(newItem)
        }
            } catch {
                print("Error saving new items,\(error)")
            }
        }

    
        self.tableView.reloadData()
      
        
        
    }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = " Create new item"
            textField = alertTextField
           
            
        }
    alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
}
   
    func loadItems() {
       todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

 tableView.reloadData()


           }
   
}

//Mark: - Search bar methods

extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)


tableView.reloadData()




     }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()

            }

        }
    }

}

