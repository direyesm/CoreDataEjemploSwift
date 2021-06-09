//
//  CoreDataManager.swift
//  ListMarket
//
//  Created by Diego on 06-06-21.
//

import Foundation
import CoreData

class CoreDataManager {
     
    let persistenContainer: NSPersistentContainer
    
    init() {
        persistenContainer = NSPersistentContainer(name: "MarketData")
        persistenContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func updateItem(){
        
        do{
            try persistenContainer.viewContext.save()
        }catch{
            persistenContainer.viewContext.rollback()
        }
    }
     
    
    func deleteItem(markets: Market){
        
        persistenContainer.viewContext.delete(markets)
        
        do{
            try persistenContainer.viewContext.save()
        } catch{
            persistenContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func getAllItem() -> [Market] {
        
        let fetchRequest: NSFetchRequest<Market> = Market.fetchRequest()
        do{
            return try persistenContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveItem(item: String){
        
        let market = Market(context: persistenContainer.viewContext)
        market.item = item
        
        do{
           try  persistenContainer.viewContext.save()
        } catch{
            print("Failed to save item \(error)")
        }
    }
}
