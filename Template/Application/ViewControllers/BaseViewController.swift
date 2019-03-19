//
//  BaseViewController.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.info("\(self.nameOfClass)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logger.info("\(self.nameOfClass)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logger.info("\(self.nameOfClass)")
    }
    
    func showLoadingView() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoadingView() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
