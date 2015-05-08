//
//  EntryDetailViewController.swift
//  PocketNanny
//
//  Created by Hao Pan on 2015-05-07.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import UIKit
import CoreData

class EntryDetailViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var entryTimestampLabel: UILabel!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // dynamic row height
        self.tableView.estimatedRowHeight = 50.0
        
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.entryTimestampLabel {
                if let timeStamp = detail.valueForKey("timeStamp") as? NSDate {
                    label.text = timeStamp.formatted
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = 0
        if let detail: AnyObject = self.detailItem {
            if let meal : AnyObject = detail.valueForKey("meal"){
                if (detail.valueForKey("meal.breastMilk") != nil) || (detail.valueForKey("meal.breastMilk") != nil) || (detail.valueForKey("meal.breastMilk") != nil) {
                    ++numberOfSections
                }
                if (detail.valueForKey("meal.breastMilk") != nil) || (detail.valueForKey("meal.breastMilk") != nil) {
                    ++numberOfSections
                }
            }
        }
        return numberOfSections;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if let detail: AnyObject = self.detailItem {
            switch section {
            case 0:
                if (detail.valueForKey("meal.breastMilk") != nil) {
                    ++numberOfRows
                }
                if (detail.valueForKey("meal.breastMilk") != nil) {
                    ++numberOfRows
                }
                if (detail.valueForKey("meal.breastMilk") != nil) {
                    ++numberOfRows
                }
                return numberOfRows
            case 1:
                if (detail.valueForKey("meal.breastMilk") != nil) {
                    ++numberOfRows
                }
                if (detail.valueForKey("meal.breastMilk") != nil) {
                    ++numberOfRows
                }
                return numberOfRows
            default:
                return numberOfRows
            }
        }
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if let s = self.fetchedResultsController.sections as? [NSFetchedResultsSectionInfo] {
//            let theSection = s[section]
//            let formatter = NSDateFormatter()
//            formatter.calendar = NSCalendar.currentCalendar()
//            
//            let formatTemplate = NSDateFormatter.dateFormatFromTemplate("MMMM d, YYYY", options: 0, locale: NSLocale.currentLocale())
//            formatter.dateFormat = formatTemplate
//            if let numericSection = theSection.name?.toInt(){
//                let year = numericSection / 10000
//                let monthday = numericSection % 10000
//                let month = monthday / 100
//                let day = monthday % 100
//                
//                let dateComponents = NSDateComponents()
//                dateComponents.year = year
//                dateComponents.month = month
//                dateComponents.day = day
//                
//                if let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents){
//                    let titleString = formatter.stringFromDate(date)
//                    return titleString
//                }
//                
//            }
//        }
//        return ""
//    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            let context = self.fetchedResultsController.managedObjectContext
//            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
//            
//            var error: NSError? = nil
//            if !context.save(&error) {
//                // Replace this implementation with code to handle the error appropriately.
//                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                //println("Unresolved error \(error), \(error.userInfo)")
//                abort()
//            }
//        }
//    }
//    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
//        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
//        if let timeStamp = object.valueForKey("timeStamp") as? NSDate {
//            cell.textLabel!.text = timeStamp.formattedTimeOnly
//        }
        
    }

}
