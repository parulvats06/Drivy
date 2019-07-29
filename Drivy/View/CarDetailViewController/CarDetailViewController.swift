//
//  CarDetailViewController.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var carDetailsTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: Constants.NibIdentifiers.carTableViewCell, bundle: nil)
            carDetailsTableView.register(nib, forCellReuseIdentifier: Constants.CellIdentifiers.carCellIdentifier)
            let nib2 = UINib(nibName: Constants.NibIdentifiers.carOwnerTableViewCell, bundle: nil)
            carDetailsTableView.register(nib2, forCellReuseIdentifier: Constants.CellIdentifiers.carOwnerCellIdentifier)
            carDetailsTableView.tableFooterView = UIView()
            carDetailsTableView.dataSource = self
            carDetailsTableView.delegate = self
        }
    }
    // MARK: - variables
    private var carDetails: Car!
    
    lazy var carDetailViewModel: CarDetailViewModel = {
        return CarDetailViewModel()
    }()
    
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
        self.title = "Car Details"
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    func bindViewModel() {
        carDetailViewModel.reloadTableClosure = { [weak self] () in
            DispatchQueue.main.async {
                //show cars
                self?.carDetailsTableView.reloadData()
            }
        }
        carDetailViewModel.loadCarItems(carModel: carDetails)
    }

}

// MARK: - Extension UITableViewDelegate delegate
extension CarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return carDetailViewModel.carItemsList.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = carDetailViewModel.carItemsList[indexPath.section]
        switch item.type {
        case .carBasicInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.carCellIdentifier, for: indexPath) as? CarTableViewCell {
                cell.configure(modelItem: item)
                return cell
            }
        case .carOwner:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.carOwnerCellIdentifier, for: indexPath) as? CarOwnerTableViewCell {
                cell.configure(modelItem: item)
                return cell
            }
        }
        
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = carDetailViewModel.carItemsList[indexPath.section]
        switch item.type {
        case .carBasicInfo:
            return 280
        case .carOwner:
            return 120
        }
    }
}
