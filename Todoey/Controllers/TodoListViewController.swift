//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Hall on 7/19/18.
//  Copyright © 2018 Anthony Hall. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController  {
    var todoItems: Results<Item>?
    let realm = try! Realm()
  
    
    @IBOutlet weak var seachBar: UISearchBar!
    
    
    
    var selectedCategory : Category? {
        didSet {
           loadItems()
        }
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     tableView.separatorStyle = .none
        
       
            
            
       
        
       
        
        
        
        
      
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let colourHex = selectedCategory?.colour {
            
            title = selectedCategory!.name
            
            guard let navBar = navigationController?.navigationBar else {fatalError("Navigation contrller does not exist.")}
            if let navBarColour = UIColor(hexString: colourHex) {
                navBar.barTintColor = navBarColour
                
                navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
                navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
                seachBar.barTintColor = UIColor(hexString: colourHex)
            }
       
            
            
        }
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row] {
        
        
        
        cell.textLabel?.text = item.title
            // opinal chaning
            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage: CGFloat(indexPath.row) /         CGFloat(todoItems!.count)) {
            cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
            }
            
            print("verison 1: \(CGFloat(indexPath.row / todoItems!.count))")
            
            print("verison 2: \(CGFloat(indexPath.row) / CGFloat (todoItems!.count))")
            
            
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
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            }catch {
                print("Error deleting items, \(error)")
            }
            }
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

