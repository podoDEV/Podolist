//
//  BaseViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let tracker = GAI.sharedInstance()?.defaultTracker else {
            return
        }
        tracker.set(kGAIScreenName, value: self.classForCoder.description())
        guard let builder = GAIDictionaryBuilder.createScreenView() else {
            return
        }
        tracker.send(builder.build() as [NSObject: AnyObject])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {

    }
}
