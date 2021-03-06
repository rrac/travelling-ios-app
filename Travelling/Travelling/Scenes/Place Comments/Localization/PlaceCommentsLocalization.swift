//
//  PlaceCommentsLocalization.swift
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

class PlaceCommentsLocalization {
    static let shared = PlaceCommentsLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
            title = "PlaceComments.scene.title",
            emptyStateText = "PlaceComments.scene.empty.state.text",
            noMorePlacesText = "PlaceComments.scene.no.more.places.text",
            errorStateText = "PlaceComments.scene.error.state.text"
    }
    
    let title = LocalizedKey.title.localized()
    let emptyStateText = LocalizedKey.emptyStateText.localized()
    let noMorePlacesText = LocalizedKey.noMorePlacesText.localized()
    let errorStateText = LocalizedKey.errorStateText.localized()
}
