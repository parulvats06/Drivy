//
//  CarDetailViewController.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {
    
    private var carDetails: Car!
    
    // MARK: - init
    init(car: Car) {
        super.init(nibName: nil, bundle: nil)
        self.carDetails = car
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
