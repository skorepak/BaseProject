//
//  Coordinator.swift
//  BaseProject
//
//  Created by Skorepa on 12.07.2017.
//  Copyright © 2017 Skorepak. All rights reserved.
//

import UIKit

//MARK: - Flow delegate protocol
protocol CoordinatorFlowDelegate: class {
    func coordinatorDidFinish(_ coordinator: Coordinator)
}

//MARK: -
class Coordinator {
    //MARK: - Instance part
    var childCoordinators = [Coordinator]()
    
    let window: UIWindow!
    var navigationController: UINavigationController?
    
    init(window: UIWindow, navigationController: UINavigationController? = nil) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            navigationController.pushViewController(viewController, animated: animated)
            
            if animated, let transitionCoordinator = navigationController.transitionCoordinator {
                transitionCoordinator.animate(alongsideTransition: nil, completion: { _ in completion?() })
            } else {
                completion?()
            }
        } else {
            let newNavigationController = UINavigationController(rootViewController: viewController)
            changeWindowControllerTo(newNavigationController, completion: completion)
            navigationController = newNavigationController
            
        }
    }
    
    func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        let _ = navigationController?.popViewController(animated: animated)
        if animated, let transitionCoordinator = navigationController?.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil, completion: { _ in completion?() })
        } else {
            completion?()
        }
    }
    
    func present(_ viewController: UIViewController, animated: Bool = false, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            viewController.modalPresentationStyle = .overFullScreen
            var presentingController: UIViewController = navigationController
            while let presentedController = presentingController.presentedViewController {
                presentingController = presentedController
            }
            DispatchQueue.main.async {
                presentingController.present(viewController, animated: animated, completion: completion)
            }
        } else {
            assert(false, "No navigation controller!")
        }
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard var presentingController: UIViewController = navigationController else {
            return
        }
        while let presentedController = presentingController.presentedViewController {
            presentingController = presentedController
        }
        presentingController.presentingViewController?.dismiss(animated: animated, completion: completion)
    }
    
    func makeActive() {
        if let navigationController = navigationController {
            changeWindowControllerTo(navigationController)
        }
    }
    
    private func changeWindowControllerTo(_ viewControler: UIViewController, completion: (() -> Void)? = nil) {
        // Place for animation if changing navigation controllers, eg. from menu
        window.rootViewController = viewControler
        completion?()
    }
}

//MARK: - Base Coordinator
extension Coordinator: BaseViewControllerCoordinator {    
    func backButtonPressed() {
        pop()
    }
}

//MARK: - FlowDelegate implementation
extension Coordinator: CoordinatorFlowDelegate {
    func coordinatorDidFinish(_ coordinator: Coordinator) {
        if childCoordinators.remove(coordinator) == nil {
            assert(false, "Finished coordinator wasnt add to child coordinators. Fix it!")
        }
    }
}

//MARK: - Equatable implementation
// Implement this for ability to use remove(object: Equatable) from array of childCoordinators
extension Coordinator: Equatable {
    public static func ==(lhs: Coordinator, rhs: Coordinator) -> Bool {
        // Two coordinators are not equal, if it's not same instance
        return lhs === rhs
    }
}
