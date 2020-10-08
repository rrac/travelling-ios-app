//
//  PlaceDetailsModels.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 08/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum PlaceDetailsModels {
    enum ItemType: CaseIterable {
        case photo
        case description
        case comments
    }
    
    struct DisplayedItem: Equatable {
        static func == (lhs: PlaceDetailsModels.DisplayedItem, rhs: PlaceDetailsModels.DisplayedItem) -> Bool {
            return lhs.type == rhs.type
        }
        
        var type: ItemType
        var model: Any?
    }
    
    class PhotoModel {
        var image: UIImage?
        var imageName: String?
        var imageContentMode: UIView.ContentMode = .scaleAspectFill
        var imageDominantColor: UIColor?
        var isLoadingImage: Bool = false
        
        weak var cellInterface: PlaceDetailsPhotoTableViewCellInterface?
    }
    
    struct DescriptionModel {
        var title: NSAttributedString?
        var text: NSAttributedString?
    }
    
    struct CommentsModel {
        var comments: NSAttributedString?
        var time: NSAttributedString?
    }
    
    enum PlaceSetup {
        struct Request {
            let place: Place
        }
    }
    
    enum PlacePresentation {
        struct Response {
            let place: Place
        }
        
        struct ViewModel {
            let items: [DisplayedItem]
        }
    }
    
    enum ImageFetching {
        struct Request {
            let model: PhotoModel
        }
        
        struct Response {
            let model: PhotoModel
        }
        
        struct ViewModel {
            let model: PhotoModel
        }
    }
    
    enum ImagePresentation {
        struct Response {
            let model: PhotoModel
            let image: UIImage?
        }
        
        struct ViewModel {
            let model: PhotoModel
            let image: UIImage?
            let contentMode: UIView.ContentMode
        }
    }
    
    enum ErrorStatePresentation {
        struct ViewModel {
            let image: UIImage?
            let text: NSAttributedString?
        }
    }
    
    enum ErrorAlertPresentation {
        struct Response {
            let error: OperationError
        }
        
        struct ViewModel {
            let title: String?
            let message: String?
            let cancelTitle: String?
        }
    }
    
    enum FullscreenImageNavigation {
        struct Response {
            let imageName: String?
        }
        
        struct ViewModel {
            let imageName: String?
        }
    }
    
    enum TitlePresentation {
        struct Response {
            let place: Place?
        }
        
        struct ViewModel {
            let title: String?
        }
    }
    
    enum PlaceSharing {
        struct Response {
            let place: Place?
        }
        
        struct ViewModel {
            let text: String
            let excludedActivityTypes: [UIActivity.ActivityType]?
        }
    }
}
