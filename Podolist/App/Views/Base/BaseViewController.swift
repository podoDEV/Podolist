//
//  BaseViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var safeAreaInset: UIEdgeInsets = .zero {
        didSet {
            setupFrame()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

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

    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        safeAreaInset = view.layoutInsets()
    }

    func setup() {

    }

    func setupFrame() {

    }
}
