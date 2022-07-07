//
//  MainServicesViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 8.07.22.
//

import UIKit

class MainServicesViewController: UIViewController {

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var segmentView: UIView!
    
    var servicesController: ServicesViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupConstraintsFor(controller: servicesController)
        setupSegmentControllers()
        title = "Услуги"
    }
    
    private func setupSegmentControllers() {
        self.servicesController = ServicesViewController(nibName: String(describing: ServicesViewController.self), bundle: nil)
        servicesController?.servicesPath = Const.Firebase.servicesPath
        setupConstraintsFor(controller: servicesController)
    }
    
    private func setupConstraintsFor(controller: UIViewController?) {
        
        guard let controller = controller else { return }
        segmentView.addSubview(controller.view)
        // отключение существующих констрейнтов для установки новых кодом
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: segmentView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: segmentView.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: segmentView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: segmentView.bottomAnchor)])
        self.addChild(controller)
        controller.didMove(toParent: self)
    }
    
    private func removeEmbeddedControllers() {
        
        servicesController?.removeFromParent()
        servicesController?.view.removeFromSuperview()
        servicesController?.didMove(toParent: nil)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        // удаление всех контроллеров
        removeEmbeddedControllers()
        if sender.selectedSegmentIndex == 0 {
            servicesController?.servicesPath = Const.Firebase.servicesPath
            setupConstraintsFor(controller: servicesController)
        } else if sender.selectedSegmentIndex == 1 {
            servicesController?.servicesPath = Const.Firebase.servicesAdditionalPath
            setupConstraintsFor(controller: servicesController)
        }
    }
}