//
//  ViewController.swift
//  Example
//
//  Created by Danil Gontovnik on 27/06/2016.
//  Copyright © 2016 Kaizen Technologies Ltd. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: Screen {
    static func construct(_: Context?) -> UIViewController {
        return ViewController()
    }
}
