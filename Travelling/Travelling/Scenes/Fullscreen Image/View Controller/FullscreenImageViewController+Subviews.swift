//
//  FullscreenImageViewController+Subviews.swift
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

extension FullscreenImageViewController {
    func setupSubviews() {
        self.setupContentView()
        self.setupScrollView()
        self.setupImageView()
        self.setupDismissButton()
    }
    
    private func setupContentView() {
        self.view.backgroundColor = FullscreenImageStyle.shared.contentViewModel.backgroundColor
    }
    
    private func setupDismissButton() {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = FullscreenImageStyle.shared.dismissButtonModel.tintColor
        button.setImage(FullscreenImageStyle.shared.dismissButtonModel.image, for: .normal)
        button.addTarget(self, action: #selector(FullscreenImageViewController.touchUpInsideDismissButton), for: .touchUpInside)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.view.addSubview(button)
        self.dismissButton = button
    }
    
    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.scrollView = scrollView
    }
    
    private func setupImageView() {
        let imageView = LoadingImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.activityIndicatorColor = FullscreenImageStyle.shared.loadingImageViewModel.activityIndicatorColor
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FullscreenImageViewController.touchUpInsideImageView(gestureRecognizer:)))
        gestureRecognizer.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(gestureRecognizer)
        self.scrollView.addSubview(imageView)
        self.imageView = imageView
    }
}

// MARK: - Actions

extension FullscreenImageViewController {
    @objc func touchUpInsideDismissButton() {
        self.router?.dismissViewController()
    }
    
    @objc func touchUpInsideImageView(gestureRecognizer: UITapGestureRecognizer) {
        if self.scrollView?.zoomScale == self.scrollView?.minimumZoomScale {
            let center = gestureRecognizer.location(in: gestureRecognizer.view)
            self.scrollView?.zoom(to: self.zoomRect(self.scrollView.maximumZoomScale, center: center), animated: true)
        } else {
            self.scrollView?.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
        }
    }
    
    private func zoomRect(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = self.imageView.frame.height / scale
        zoomRect.size.width = self.imageView.frame.width / scale
        let newCenter = self.scrollView.convert(center, to: self.imageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2)
        return zoomRect
    }
}

// MARK: - Constraints

extension FullscreenImageViewController {
    func setupSubviewsConstraints() {
        self.setupScrollViewConstraints()
        self.setupImageViewConstraints()
        self.setupDismissButtonConstraints()
    }
    
    private func setupDismissButtonConstraints() {
        NSLayoutConstraint.activate([
            self.dismissButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.dismissButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        ])
    }
}
