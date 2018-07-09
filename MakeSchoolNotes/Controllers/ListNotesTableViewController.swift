//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    // MARK: - Properties
    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = CoreDataHelper.retrieveNotes()
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            CoreDataHelper.delete(note: noteToDelete)
            
            notes = CoreDataHelper.retrieveNotes()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        // 2
        let note = notes[indexPath.row]
        
        cell.noteTitleLabel.text = note.title
        // 3
        cell.lastModificationTimeLabel.text = note.modificationTime?.convertToString() ?? "unknown"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayNote":
            // 1
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
           // 2
            let note = notes[indexPath.row]
//            notes.insert(note, at: 0)
            
//            var i = 0
//            for not in notes[] {
//                var thisNote = not
            //    notes[i+1] = not
//                i++
//
//            }
//            let note = notes[0]
            
            // 3
            let destination = segue.destination as! DisplayNoteViewController
            
            // 4
            destination.note = note
            
        case "addNote":
            print("create note bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        notes = CoreDataHelper.retrieveNotes()
    }
    
}
