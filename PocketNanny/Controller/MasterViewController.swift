//
//  MasterViewController.swift
//  PocketNanny
//
//  Created by Anthony Pan on 2015-04-21.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, UIActionSheetDelegate {

    var entryDetailViewController: EntryDetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 65.0
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.entryDetailViewController = controllers[controllers.count-1].topViewController as? EntryDetailViewController
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        let context = self.fetchedResultsController.managedObjectContext
        
        let optionMenu = UIAlertController(title: nil, message: NSLocalizedString("eventAddTitle", comment: "New Item"), preferredStyle: .ActionSheet)
        
        let milkButton = UIAlertAction(title: NSLocalizedString("milk", comment: "Milk"), style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            // creating a meal
            if let meal = NSEntityDescription.entityForName("Meal", inManagedObjectContext: self.managedObjectContext!) {
                let newMeal = NSEntityDescription.insertNewObjectForEntityForName(meal.name!, inManagedObjectContext: context) as! Meal
                
                let entity = self.fetchedResultsController.fetchRequest.entity!
                let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! Event
                
                newManagedObject.timeStamp = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components((.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay), fromDate: NSDate())
                newManagedObject.sectionIdentifier = "\(components.year * 10000 + components.month * 100 + components.day)"
                
                newManagedObject.meal = newMeal
                var error: NSError? = nil
                if !context.save(&error) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    //println("Unresolved error \(error), \(error.userInfo)")
                    abort()
                }
            }
        })
        let cerealButton = UIAlertAction(title: NSLocalizedString("sleep", comment: "Sleep"), style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            // creating a cereal
            if let sleep = NSEntityDescription.entityForName("Sleep", inManagedObjectContext: self.managedObjectContext!) {
                let newSleep = NSEntityDescription.insertNewObjectForEntityForName(sleep.name!, inManagedObjectContext: context) as! Sleep
                
                let entity = self.fetchedResultsController.fetchRequest.entity!
                let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! Event
                
                newManagedObject.timeStamp = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components((.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay), fromDate: NSDate())
                newManagedObject.sectionIdentifier = "\(components.year * 10000 + components.month * 100 + components.day)"
                
                newManagedObject.sleep = newSleep
                var error: NSError? = nil
                if !context.save(&error) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    //println("Unresolved error \(error), \(error.userInfo)")
                    abort()
                }
            }
        })
        let diaperButton = UIAlertAction(title: NSLocalizedString("diaper", comment: "Diaper"), style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            if let diaper = NSEntityDescription.entityForName("Diaper", inManagedObjectContext: self.managedObjectContext!) {
                let newDiaper = NSEntityDescription.insertNewObjectForEntityForName(diaper.name!, inManagedObjectContext: context) as! Diaper
                
                let entity = self.fetchedResultsController.fetchRequest.entity!
                let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! Event
                
                newManagedObject.timeStamp = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components((.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay), fromDate: NSDate())
                newManagedObject.sectionIdentifier = "\(components.year * 10000 + components.month * 100 + components.day)"
                
                newManagedObject.diaper = newDiaper
                var error: NSError? = nil
                if !context.save(&error) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    //println("Unresolved error \(error), \(error.userInfo)")
                    abort()
                }
            }
        })
        let cancelButton = UIAlertAction(title: NSLocalizedString("cancel", comment: "Cancel"), style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("canceled")
        })
        
        optionMenu.addAction(milkButton)
        optionMenu.addAction(cerealButton)
        optionMenu.addAction(diaperButton)
        optionMenu.addAction(cancelButton)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
            let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Event
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! EntryDetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EntryCell", forIndexPath: indexPath) as! EntryTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let s = self.fetchedResultsController.sections as? [NSFetchedResultsSectionInfo] {
            let theSection = s[section]
            let formatter = NSDateFormatter()
            formatter.calendar = NSCalendar.currentCalendar()
            
            let formatTemplate = NSDateFormatter.dateFormatFromTemplate("MMMM d, YYYY", options: 0, locale: NSLocale.currentLocale())
            formatter.dateFormat = formatTemplate
            if let numericSection = theSection.name?.toInt(){
                let year = numericSection / 10000
                let monthday = numericSection % 10000
                let month = monthday / 100
                let day = monthday % 100
                
                let dateComponents = NSDateComponents()
                dateComponents.year = year
                dateComponents.month = month
                dateComponents.day = day
                
                if let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents){
                    let titleString = formatter.stringFromDate(date)
                    return titleString
                }
                
            }
        }
        return ""
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! Event)
                
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    func configureCell(cell: EntryTableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Event
        cell.timeStamp!.text  = object.timeStamp.formattedTimeOnly
//        cell.textLabel!.text = timeStamp.formattedTimeOnly
        if let meal = object.meal as? Meal {
            cell.typeImage.image = UIImage(named: "babyBottle")
            cell.detailLabel!.text = "test"
        }
        if let sleep = object.sleep as? Sleep {
            cell.typeImage.image = UIImage(named: "babyBottle")
            cell.detailLabel!.text = "test"
        }
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: "sectionIdentifier", cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
    	var error: NSError? = nil
    	if !_fetchedResultsController!.performFetch(&error) {
    	     // Replace this implementation with code to handle the error appropriately.
    	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //println("Unresolved error \(error), \(error.userInfo)")
    	     abort()
    	}
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                let cell = tableView.cellForRowAtIndexPath(indexPath!) as! EntryTableViewCell
                self.configureCell(cell, atIndexPath: indexPath!)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

