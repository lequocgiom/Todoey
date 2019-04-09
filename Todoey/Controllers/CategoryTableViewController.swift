//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Le Trung on 4/9/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    //MARK: Table view datasource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("category cellForRowAt indexPath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        
        return cell
    }
    
    
    //MARK: Add new Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            
            textField = alertTextField
            alertTextField.placeholder = "Create new item"
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    //MARK: Data manipulation method
    
    
    func saveCategories() {
        do {
            try context.save()
        }
            
        catch{
            print("Error saving category, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error loading categories, \(error)")
        }
        
        tableView.reloadData()
        
    }
    //MARK: Table view Delegate method
    
    
}

extension CategoryTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        request.predicate =  NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadCategories(with: request)
        //        do {
        //            itemArray = try context.fetch(request)
        //        }
        //        catch {
        //            print("Error fetching data from context, \(error)")
        //        }
        
        //        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadCategories()
            
            searchBar.resignFirstResponder()
        }
    }
}
