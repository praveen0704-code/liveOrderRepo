//
//  CoreDataLO.swift
//  liveOrder
//
//  Created by PraveenMac on 13/10/21.
//

import Foundation
import CoreData
import UIKit


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let searchListEntityNameConStr = "RecentSearchLO"
var recentSearchMod = [RecentSearchModel]()





//FIXME: - SaveTo core Data lCMainSearch
func saveDateToCore(searchTextStr:String,entityName:String){
    
    let quoteContext = appDelegate.persistentContainer.viewContext
    
    let quoteEntity = NSEntityDescription.entity(forEntityName: entityName, in: quoteContext)
    
    let saveQuote = NSManagedObject(entity: quoteEntity!, insertInto: quoteContext)
   
    saveQuote.setValue(searchTextStr, forKey: "searchTextLO")
    
    do {
        try quoteContext.save()
        print("saved")
    } catch {
        print("Failed saving")
    }
    
}
func deleteAllItems(entity: String) -> Bool {
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let managedContext = appDelegate.persistentContainer.viewContext
let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
fetchRequest.returnsObjectsAsFaults = false
var deleteBool = Bool()
do
{
    let results = try managedContext.fetch(fetchRequest)
    for managedObject in results
    {
        let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
        managedContext.delete(managedObjectData)
        print("deleted all")
        
    }
    deleteBool = true

} catch let error as NSError {
    print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
    deleteBool = false
}
    return deleteBool
}




