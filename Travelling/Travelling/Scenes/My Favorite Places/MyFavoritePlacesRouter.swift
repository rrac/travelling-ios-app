//
//  MyFavoritePlacesRouter.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 11/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyFavoritePlacesRoutingLogic {
    func navigateToPlaceDetails(place: Place)
}

class MyFavoritePlacesRouter: MyFavoritePlacesRoutingLogic {
    weak var viewController: MyFavoritePlacesViewController?
    
    func navigateToPlaceDetails(place: Place) {
        let placeDetailsViewController = PlaceDetailsViewController(place: place)
        placeDetailsViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(placeDetailsViewController, animated: true)
    }
}