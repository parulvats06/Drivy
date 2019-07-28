//
//  CarListViewController.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView! {
        didSet {
            loadingActivityIndicator.color = .drivyBlue
            loadingActivityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var carsTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: Constants.NibIdentifiers.carTableViewCell, bundle: nil)
            carsTableView.register(nib, forCellReuseIdentifier: Constants.CellIdentifiers.carCellIdentifier)
            carsTableView.separatorStyle = .none
            carsTableView.dataSource = self
            carsTableView.delegate = self
            carsTableView.reloadData()
        }
    }
    
    // MARK: - Variables
    lazy var carListViewModel: CarListViewModel = {
        return CarListViewModel()
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Available cars"
        // Do any additional setup after loading the view.
        bindViewModel()
    }

    func bindViewModel() {
        carListViewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.carListViewModel.alertMessage {
                    self?.showAlert(title: "Alert", message: message)
                }
            }
        }
        
        carListViewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.carListViewModel.isLoading ?? false
                if isLoading {
                    self?.loadingActivityIndicator.startAnimating()
                }else {
                    self?.loadingActivityIndicator.stopAnimating()
                }
            }
        }
        
        carListViewModel.reloadTableClosure = { [weak self] () in
            DispatchQueue.main.async {
                //show cars
                self?.carsTableView.reloadData()
            }
        }
        carListViewModel.fetchCars()
    }

}

// MARK: - Extension UITableViewDelegate delegate
extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return carListViewModel.carList.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.carCellIdentifier, for: indexPath) as? CarTableViewCell else {
            fatalError("Cell does not exists")
        }
        let carModel = carListViewModel.carList[indexPath.section]
        cell.configure(model: carModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let model = carListViewModel.carList[indexPath.section]
        
        let viewController = CarDetailViewController(car: model)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.backgroundView?.backgroundColor = UIColor.clear
        }
    }
}
