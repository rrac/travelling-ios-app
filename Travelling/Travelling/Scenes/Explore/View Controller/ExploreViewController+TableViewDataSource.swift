//
//  ExploreViewController+TableViewDataSource.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 13/09/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

extension ExploreViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedItem = self.sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.defaultReuseIdentifier, for: indexPath) as! ExploreTableViewCell
        displayedItem.cellInterface = cell
        cell.setTitle(title: displayedItem.title)
        cell.setImageDominantColor(color: displayedItem.imageDominantColor)
        cell.setImage(image: displayedItem.image, contentMode: displayedItem.imageContentMode)
        cell.setIsLoadingImage(isLoading: displayedItem.isLoadingImage)
        self.interactor?.shouldFetchImage(request: ExploreModels.ImageFetching.Request(item: displayedItem))
        return cell
    }
}
