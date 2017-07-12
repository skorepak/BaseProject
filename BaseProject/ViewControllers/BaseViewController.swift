//
//  BaseViewController.swift
//  BaseProject
//
//  Created by Skorepa on 12.07.2017.
//  Copyright © 2017 Skorepak. All rights reserved.
//

import UIKit

protocol BaseViewControllerCoordinator: class {
    func backButtonPressed()
}

class BaseViewController: UIViewController {
    
    unowned fileprivate let coordinator: BaseViewControllerCoordinator
    
    //MARK: - Instance part
    init(coordinator: BaseViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func backButtonPressed() {
        coordinator.backButtonPressed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Helpers
    private func configureNavigationBar() {
        guard let navigationController = navigationController else { return }
        
        if navigationController.viewControllers.count > 1 {
            setupBackButton()
        }
    }
    
    private func setupBackButton() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }
    
    private var backButton: UIBarButtonItem {
        let image = #imageLiteral(resourceName: "backButton")
        let button: UIButton = UIButton(frame: CGRect(x:0, y: 0, width: 13, height: 21))
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        let backButton = UIBarButtonItem(customView: button)
        return backButton
    }
}
