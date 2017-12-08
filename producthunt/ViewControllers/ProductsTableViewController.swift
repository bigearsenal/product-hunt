//
//  ProductsTableViewController.swift
//  producthunt
//
//  Created by Chung Tran on 08/12/2017.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    @IBOutlet weak var btnChooseTopic: UIButton!
    
    var posts: [Post] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Retrieve title
        getTitleForBtnChooseTopic()
        
        // Prepare for fetching
        self.refreshControl?.beginRefreshing()
        
        Post.getAll { (error, posts) in
            if error != nil {
                // TODO: Error handling
            } else if posts != nil {
                self.posts = posts!
            }
            self.refreshControl?.endRefreshing()
        }
    }

    
    // MARK: - Actions
    func getTitleForBtnChooseTopic() {
        btnChooseTopic.setTitle(Setting.currentTopicSlug, for: .normal)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }

}
