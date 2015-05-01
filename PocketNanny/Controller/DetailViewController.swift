//
//  DetailViewController.swift
//  PocketNanny
//
//  Created by Anthony Pan on 2015-04-21.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                let timeStamp = detail.valueForKey("timeStamp")!.description
                let identifier = detail.valueForKey("sectionIdentifier")!.description
                label.text = "\(timeStamp)\n\(identifier)"
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


}

