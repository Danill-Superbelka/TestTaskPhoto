//
//  UsersTableViewController.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    private var userViewModel: UsersViewModel?
    var users: Users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        configTableView()
    }
    
    func configTableView(){
        self.userViewModel = UsersViewModel()
        self.userViewModel!.bindUserViewModel = {
            self.users = self.userViewModel!.users
            self.tableView.reloadData()
        }
    }
        
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count != 0 ? users.count:1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        if users.count != 0 {
            cell.textLabel?.text = users[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row].id
       
        var urlComps = URLComponents(string: "\(ApiType.getAlbums.request)")
        let queryItems = [URLQueryItem(name: "userId", value: "\(user)")]
        urlComps?.queryItems = queryItems
        let result = URLRequest(url: (urlComps?.url)!)
        
        
        ApiManager.shared.getData(request: result) { (data: Albums?) in
           
            let firstAlbum = "\(String(describing: data?.first?.id ?? 0))"
            let lastAlbum =  "\(String(describing: data?.last?.id ?? 0))"
            
            var urlComps = URLComponents(string: "\(ApiType.getPhotos.request)")
            let queryItems = [URLQueryItem(name: "albumId_gte", value: firstAlbum), URLQueryItem(name: "albumId_lte", value: lastAlbum)]
            urlComps?.queryItems = queryItems
            ApiManager.shared.songsURL = URLRequest(url: (urlComps?.url)!)
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoCollectionViewController") as? PhotoCollectionViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
