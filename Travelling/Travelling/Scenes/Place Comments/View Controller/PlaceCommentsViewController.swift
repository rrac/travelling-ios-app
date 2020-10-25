//
//  PlaceCommentsViewController.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 12/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class PlaceCommentsViewController: UITableViewController {
    var interactor: PlaceCommentsBusinessLogic?
    var router: PlaceCommentsRoutingLogic?
    
    var placeId: String?
    var sections: [PlaceCommentsModels.Section] = [PlaceCommentsModels.Section(), PlaceCommentsModels.Section()]
    
    // MARK: - Object lifecycle
    
    convenience init(placeId: String?) {
        self.init(style: .grouped)
        self.placeId = placeId
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = PlaceCommentsInteractor()
        let presenter = PlaceCommentsPresenter()
        let router = PlaceCommentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.displayer = viewController
        router.viewController = viewController
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.interactor?.shouldSetPlace(request: PlaceCommentsModels.PlaceSetup.Request(placeId: self.placeId))
        self.interactor?.shouldFetchItems()
    }
}

extension PlaceCommentsViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != self.traitCollection.preferredContentSizeCategory {
            self.interactor?.shouldFetchItems()
        }
    }
}