//
//  BaseViewController.swift
//  githubDemo
//
//  Created by Edwin Weru on 27/05/2022.
//

import RxSwift
import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    associatedtype T
    init(viewModel: T)
}

class BaseViewController<U>: UIViewController, BaseViewControllerProtocol {
    typealias T = U
    let viewModel: T
    let disposeBag = DisposeBag()

    convenience init() {
        fatalError("init() has not been implemented")
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
}
