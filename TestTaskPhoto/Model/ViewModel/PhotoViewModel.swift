//
//  PhotoViewModel.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 23.01.2022.
//

import Foundation

class PhotoViewModel: NSObject {
    private var api: ApiManager!
    
    var bindPhotoViewModel : (()->()) = {}
    
    private(set) var photos: Photos! {
        didSet {
            self.bindPhotoViewModel()
        }
    }
    
    override init() {
        super.init()
        self.api = ApiManager.shared
        getData()
    }
    
    func getData() {
        self.api.getData(request: ApiManager.shared.songsURL!) { (data: Photos?) in
            self.photos = data
       }
    }
}
