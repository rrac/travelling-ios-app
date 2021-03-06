//
//  SignUpStyle.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 06/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class SignUpStyle {
    static let shared = SignUpStyle()
    
    var navigationBarModel: NavigationBarModel
    var contentViewModel: ContentViewModel
    
    var photoCellModel: PhotoCellModel
    var textFieldCellModel: TextFieldCellModel
    var textViewCellModel: TextViewCellModel
    var buttonCellModel: ButtonCellModel
    var imageItemModel: ImageItemModel
    
    private init() {
        self.navigationBarModel = NavigationBarModel()
        self.contentViewModel = ContentViewModel()
        self.photoCellModel = PhotoCellModel()
        self.textFieldCellModel = TextFieldCellModel()
        self.textViewCellModel = TextViewCellModel()
        self.buttonCellModel = ButtonCellModel()
        self.imageItemModel = ImageItemModel()
    }
    
    struct NavigationBarModel {
        var isTranslucent: Bool = false
        var tintColor: UIColor = ApplicationStyle.colors.primary
        var barTintColor: UIColor = ApplicationStyle.colors.primaryLight
        
        func titleAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primary,
                NSAttributedString.Key.font: ApplicationStyle.fonts.bold(size: UIFont.labelFontSize)
            ]
        }
    }
    
    struct ContentViewModel {
        var backgroundColor = ApplicationStyle.colors.accentAlpha
    }
    
    struct PhotoCellModel {
        var backgroundColor: UIColor = ApplicationStyle.colors.primaryLight
        
        var placeholderImage: UIImage = ApplicationStyle.images.placeholderImageIcon
        var imageBackgroundColor: UIColor = ApplicationStyle.colors.accent
        
        var buttonBackgroundColor: UIColor = ApplicationStyle.colors.primary
        var buttonCornerRadius: CGFloat = 5
        var buttonContentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        func buttonTextAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primaryLight,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .callout)
            ]
        }
    }
    
    struct ImageItemModel {
        var imageWidth: CGFloat = 120
        var imageHeight: CGFloat = 120
        var imageBorderColor: UIColor = ApplicationStyle.colors.primary
        var imageBorderWidth: CGFloat = 1
    }
    
    struct TextFieldCellModel {
        var backgroundColor: UIColor = ApplicationStyle.colors.primaryLight
        var borderWidth: CGFloat = 1
        var borderColor: CGColor = ApplicationStyle.colors.accent.cgColor
        var errorBorderColor: CGColor = ApplicationStyle.colors.tertiary.cgColor
        var cornerRadius: CGFloat = 5
        
        func titleAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.accent,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .footnote)
            ]
        }
        
        func textAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primary,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .callout)
            ]
        }
        
        func placeholderAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.accent,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .callout)
            ]
        }
        
        func errorTextAttributes() -> [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.tertiary,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .footnote),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        }
    }
    
    struct TextViewCellModel {
        var backgroundColor: UIColor = ApplicationStyle.colors.primaryLight
        var borderWidth: CGFloat = 1
        var borderColor: CGColor = ApplicationStyle.colors.accent.cgColor
        var errorBorderColor: CGColor = ApplicationStyle.colors.tertiary.cgColor
        var cornerRadius: CGFloat = 5
        
        func titleAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.accent,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .footnote)
            ]
        }
        
        func textAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primary,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .callout)
            ]
        }
        
        func placeholderAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.accent,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .callout)
            ]
        }
        
        func errorTextAttributes() -> [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.tertiary,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .footnote),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        }
    }
    
    struct ButtonCellModel {
        var backgroundColor: UIColor = ApplicationStyle.colors.primaryLight
        var enabledBackgroundColor: UIColor = ApplicationStyle.colors.primary
        var disabledBackgroundColor: UIColor = ApplicationStyle.colors.primary.withAlphaComponent(0.5)
        var cornerRadius: CGFloat = 5
        var activityIndicatorColor: UIColor = ApplicationStyle.colors.primaryLight
        var contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        
        func textAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primaryLight,
                NSAttributedString.Key.font: ApplicationStyle.fonts.preferredFont(style: .callout)
            ]
        }
    }
}
