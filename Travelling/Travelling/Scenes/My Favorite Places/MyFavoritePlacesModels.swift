//
//  MyFavoritePlacesModels.swift
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

enum MyFavoritePlacesModels {
    class PaginationModel {
        var isSearchingItems: Bool = false
        var isFetchingItems: Bool = false
        var noMoreItems: Bool = false
        var hasError: Bool = false
        var currentPage: Int = 0
        var limit: Int = 30
        var items: [Place] = []
    }
    
    class Section {
        var items: [DisplayedItem] = []
        var isLoading: Bool = false
        var hasError: Bool = false
        var errorText: NSAttributedString?
        var noMoreItems: Bool = false
        var noMoreItemsText: NSAttributedString?
    }
    
    enum SectionIndex: Int {
        case items = 0
        case footer = 1
    }
    
    class DisplayedItem {
        var id: String
        var title: NSAttributedString?
        var subtitle: NSAttributedString?
        
        var image: UIImage?
        var imageName: String?
        var imageContentMode: UIView.ContentMode = .scaleAspectFill
        var imageDominantColor: UIColor?
        var isLoadingImage: Bool = false
        
        var isFavorite: Bool = false
        
        weak var cellInterface: MyFavoritePlacesTableViewCellInterface?
        
        init(id: String) {
            self.id = id
        }
    }
    
    enum ItemsPresentation {
        struct Response {
            let items: [Place]
        }
        
        struct ViewModel {
            let displayedItems: [DisplayedItem]
        }
    }
    
    enum NoMoreItemsPresentation {
        struct ViewModel {
            let text: NSAttributedString?
        }
    }
    
    enum EmptyStatePresentation {
        struct ViewModel {
            let image: UIImage?
            let text: NSAttributedString?
        }
    }
    
    enum ErrorStatePresentation {
        struct ViewModel {
            let text: NSAttributedString?
        }
    }
    
    enum ImageFetching {
        struct Request {
            let item: DisplayedItem
        }
        
        struct Response {
            let item: DisplayedItem
        }
        
        struct ViewModel {
            let item: DisplayedItem
        }
    }
    
    enum ImagePresentation {
        struct Response {
            let item: DisplayedItem
            let image: UIImage?
        }
        
        struct ViewModel {
            let item: DisplayedItem
            let image: UIImage?
            let contentMode: UIView.ContentMode
        }
    }
    
    enum ItemsSearching {
        struct Request {
            let text: String?
        }
        
        struct Response {
            let text: String
            let items: [Place]
        }
    }
    
    enum ItemNavigation {
        struct Request {
            let id: String
        }
        
        struct Response {
            let place: Place
        }
        
        struct ViewModel {
            let place: Place
        }
    }
    
    enum UserLogin {
        struct Request {
            let user: User
        }
    }
    
    enum ItemDelete {
        struct Request {
            let id: String
        }
        
        struct Response {
            let id: String
        }
        
        struct ViewModel {
            let id: String
        }
    }
}