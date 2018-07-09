//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Lekha Adari on 7/6/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
        
    }()
    
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print ("could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(note: Note) {
        context.delete(note)
        
        saveNote()
    }
    
    static func retrieveNotes() -> [Note] {
        do{
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)
            
            let sorted = results.sorted(by: {$0.modificationTime! > $1.modificationTime!})
            //            results.sorted { (first, last) -> Bool in
            //                return first.modificationTime! > last.modificationTime!
            //            }
            return sorted
            
        } catch let error {
            print ("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}
