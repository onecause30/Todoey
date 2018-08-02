//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Anthony Hall on 7/25/18.
//  Copyright © 2018 Anthony Hall. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    var categories: Results<Category>?
    let realm = try! Realm()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
        
tableView.reloadData()
    }
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
        
       }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
                cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
       cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].colour ?? "007AFF")
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVc.selectedCategory = categories?[indexPath.row]
        }
        
    }
    //Mark: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving catrgory \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
         categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    //Mark - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoreyForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoreyForDeletion)
                }
            }catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    
    
    
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        let newCategory = Category()
        newCategory.name = textField.text!
          newCategory.colour = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
    present(alert, animated: true, completion: nil)
  
 
    
    
    }
    

}
















