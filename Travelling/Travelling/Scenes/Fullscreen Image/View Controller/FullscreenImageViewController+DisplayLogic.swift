//
//  FullscreenImageViewController+DisplayLogic.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 04/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FullscreenImageDisplayLogic: class {
    func displayWillFetchImage()
    func displayDidFetchImage()
    func displayImage(viewModel: FullscreenImageModels.ImagePresentation.ViewModel)
}

extension FullscreenImageViewController: FullscreenImageDisplayLogic {
    func displayWillFetchImage() {
        DispatchQueue.main.async {
            self.imageView?.setLoading(isLoading: true)
        }
    }
    
    func displayDidFetchImage() {
        DispatchQueue.main.async {
            self.imageView?.setLoading(isLoading: false)
        }
    }
    
    func displayImage(viewModel: FullscreenImageModels.ImagePresentation.ViewModel) {
        DispatchQueue.main.async {
            self.imageView?.image = viewModel.image
            self.imageView?.contentMode = viewModel.contentMode
        }
    }
}