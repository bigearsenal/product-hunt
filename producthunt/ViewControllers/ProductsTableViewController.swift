//
//  ProductsTableViewController.swift
//  producthunt
//
//  Created by Chung Tran on 08/12/2017.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import UIKit
import SDWebImage
import ProgressHUD

class ProductsTableViewController: UITableViewController {
    
    @IBOutlet weak var btnChooseTopic: UIButton!
    
    var posts: [Post] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add pull-to-refresh feature
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // retrieve data
        refreshData()
        
        // Register for topic changing
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name(rawValue: Setting.CurrentTopicSlugDidChangeNotification), object: nil)
    }

    
    // MARK: - Actions
    func getTitleForBtnChooseTopic() {
        btnChooseTopic.setTitle(Setting.currentTopicSlug, for: .normal)
    }
    
    
    @objc func refreshData() {
        // Retrieve title
        getTitleForBtnChooseTopic()
        
        ProgressHUD.show("Loading...", interaction: false)
        Post.getAll { (error, posts) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
            } else if posts != nil {
                self.posts = posts!
                ProgressHUD.dismiss()
            }
            self.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = posts[indexPath.row]
        cell.titleLabel.text = post.name
        cell.descriptionLabel.text = post.description
        cell.upvotesLabel.text = "\(post.voteCount ?? 0) upvotes"
        cell.thumbnailImage.sd_setImage(with: URL(string: post.thumbnailImage!)!, completed: nil)
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToPostDetail", sender: posts[indexPath.row])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPostDetail" {
            let destination = segue.destination as! PostDetailViewController
            destination.post = (sender as! Post)
        }
    }

}
