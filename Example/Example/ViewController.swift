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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: Screen {
    static func construct(color: UIColor?) -> UIViewController {
        let vc = ViewController()
        vc.view.backgroundColor = color
        return vc
    }
}
