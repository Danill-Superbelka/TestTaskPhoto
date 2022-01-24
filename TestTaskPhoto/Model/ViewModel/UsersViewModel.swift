//
//  UsersViewModel.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 22.01.2022.

import Foundation

class UsersViewModel: NSObject {
    private var api: ApiManager!
    
    var bindUserViewModel : (()->()) = {}
    
    private(set) var users: Users! {
        didSet {
            self.bindUserViewModel()
        }
    }
    
    override init() {
        super.init()
        self.api = ApiManager.shared
        getData()
    }
    
    func getData() {
        let request = ApiType.getUsers.request
        self.api.getData(request: request) { (data: Users?) in
            self.users = data
       }
    }
}
