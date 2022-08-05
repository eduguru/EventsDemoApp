//
//  UIAlertController.swift
//  Little Agent
//
//  Created by edwin weru on 19/04/2021.
//

import Foundation
import UIKit

// Source: http://stackoverflow.com/a/40634752/3400034
extension UIAlertController {
    func tapButton(at index: Int, animated: Bool) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.tapButton(at: index, animated: animated)
            }
            return
        }

        if index >= 0, index < actions.count,
           let block = actions[index].value(forKey: "handler")
        {
            typealias AlertHandler = @convention(block) (UIAlertAction) -> Void
            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
            let handler = unsafeBitCast(blockPtr, to: AlertHandler.self)
            presentingViewController?.dismiss(animated: animated, completion: { [unowned self] in
                handler(self.actions[index])
            })
        }
    }
}

// let alert = UIAlertController(title: "Hello", message: "world", preferredStyle: .alert)
// alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (a: UIAlertAction) in
//    print("tappedAction")
// }))
//
//
// alert.tapButton(at: 0, animated: false)
