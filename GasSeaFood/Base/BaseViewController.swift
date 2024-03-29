//
//  BaseViewController.swift
//  BlackSreenVideo
//
//  Created by 陳逸煌 on 2022/11/23.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    
    public var navigationTitle: String? = ""
    
    public var bottomBarHeight: CGFloat = 0
    
    public var barAppearanceBackgroundColor: UIColor = .white
    

    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationtitle()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.defaultNavigationSet()
        KeyboardHelper.shared.registFor(viewController: self)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        KeyboardHelper.shared.unregist()
    }
    
    public func showAlert(title:String = "提示",message: String = "",confirmTitle: String = "OK",cancelTitle: String = "取消",confirmAction: (()->())? = nil,cancelAction:(()->())? = nil){
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                if let confirmAction = confirmAction {
                    confirmAction()
                }
            }
            controller.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                if let cancelAction = cancelAction {
                    cancelAction()
                }
            }
            controller.addAction(cancelAction)
            
            self.present(controller, animated: true, completion: nil)
        }

    }
    
    public func showSingleAlert(title:String = "提示",message: String = "",confirmTitle: String = "OK",confirmAction: (()->())? = nil){
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                if let confirmAction = confirmAction {
                    confirmAction()
                }
            }
            controller.addAction(okAction)
            
            self.present(controller, animated: true, completion: nil)
        }

    }
    
    public func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
            alert.addTextField { (textField:UITextField) in
                textField.placeholder = inputPlaceholder
                textField.keyboardType = inputKeyboardType
            }
            alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
                guard let textField =  alert.textFields?.first else {
                    actionHandler?(nil)
                    return
                }
                actionHandler?(textField.text)
            }))
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
            
            self.present(alert, animated: true, completion: nil)
        }

    }



    
    
    private func setupNavigationtitle() {
        if let naviTitle = self.navigationTitle {
            self.title = naviTitle
        }
    }
    
    
    public func showToast(message:String, complete: (()->())? = nil) {
        DispatchQueue.main.async {
            guard self.presentedViewController?.classForCoder != UIAlertController.self else { return }
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.global().async {
                sleep(1)
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: nil)
                    complete?()
                }
            }
        }
    }
    
    func defaultNavigationSet() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .init(hex: "3472D9")
        UINavigationBar.appearance().tintColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
       
    }
 
}
