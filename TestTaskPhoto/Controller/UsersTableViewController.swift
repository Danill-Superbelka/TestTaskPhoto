//
//  UsersTableViewController.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.
//

import UIKit

class UsersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestUsers = ApiType.getUsers.request
        ApiManager.shared.getData(request: requestUsers){ (data: Users?) in
            print(data!)
            // Работа с данными
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    

   

}
