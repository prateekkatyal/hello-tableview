//
//  HelloTableViewController.swift
//  Hello App
//
//  Created by Prateek Katyal on 08/10/18.
//  Copyright © 2018 Prateek Katyal. All rights reserved.
//

import UIKit

class HelloTableViewController: UITableViewController {
    
    // Creating an Array of Objects from Core Data
    
    var hello = [Hello]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calling the function getHello everytime viewDidLoad is called.
        
        getHello()
        

        
    }
    
    func getHello() {
        
        // Initialise CoreData Context & getting data from Entity in CoreData
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let toDosFromCoreData = try? context.fetch(Hello.fetchRequest()) {
                
                if let tempToDos = toDosFromCoreData as? [Hello] {
                    hello = tempToDos
                    
                    tableView.reloadData()
                    
                }
                
            }
            
        }
        
    }

    

    
    
   
    // What to display in the tableview?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = UITableViewCell()
    
        // What should be displayed in cell?
        
         cell.textLabel?.text = hello[indexPath.row].title
        
        
        return cell
 
    
        
    }
    

    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
        
    }

    
    // Delete Cell on tap
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let selectedHello = hello[indexPath.row]
            
            // Delete the selected cell from coreData
            
            context.delete(selectedHello)
            tableView.reloadData()
            
            
        }
        
        // Save data in core Data Entity after changes
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        
    }

    
    
    // How many cells in tableview?

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        // Answering how many cells should be there in the TableView
        
        
        return hello.count
        
        
        
    }
    
    
    
    // Add item to CoreData on tap of Add button.

   
    @IBAction func addHello(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let newHello = Hello(context: context)
            
            newHello.title = "Hello"
            
            tableView.reloadData()
            
            
            
        }
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        
    }
    
    
}
