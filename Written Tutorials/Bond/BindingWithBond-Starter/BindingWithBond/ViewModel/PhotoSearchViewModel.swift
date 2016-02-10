//
//  PhotoSearchViewModel.swift
//  BindingWithBond
//
//  Created by Tim Fuqua on 2/9/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import Bond

class PhotoSearchViewModel {
  
  private let searchService: PhotoSearch = {
    let apiKey = NSBundle.mainBundle().objectForInfoDictionaryKey("apiKey") as! String
    return PhotoSearch(key: apiKey)
  }()
  
  let searchString = Observable<String?>("")
  let validSearchText = Observable<Bool>(false)
  let searchResults = ObservableArray<Photo>()
  let searchInProgress = Observable<Bool>(false)
  let errorMessages = EventProducer<String>()
  
  let searchMetadataViewModel = PhotoSearchMetadataViewModel()
  
  init() {
    searchString.value = "trees"
    
    searchString
      .filter { $0!.length() > 3 }
      .throttle(0.5, queue: Queue.Main)
      .observe {
        [unowned self] text in
        self.executeSearch(text!)
      }
    
    searchString
      .map { $0!.length() > 3 }
      .bindTo(validSearchText)
  }
  
  func executeSearch(text: String) {
    var query = PhotoQuery()
    query.text = searchString.value ?? ""
    query.creativeCommonsLicence = searchMetadataViewModel.creativeCommons.value
    query.dateFilter = searchMetadataViewModel.dateFilter.value
    query.minDate = searchMetadataViewModel.minUploadDate.value
    query.maxDate = searchMetadataViewModel.maxUploadDate.value
    
    searchInProgress.value = true
    
    searchService.findPhotos(query) {
      [unowned self] result in
      
      self.searchInProgress.value = false
      
      switch result {
      case .Success(let photos):
        print("500px API returned \(photos.count) photos")
        self.searchResults.removeAll()
        self.searchResults.insertContentsOf(photos, atIndex: 0)
      case .Error:
        print("Sad face :[")
        self.errorMessages.next("There was an API request issue of some sort. Go ahead, hit me with that 1-star review!")
      }
    }
  }
  
}
