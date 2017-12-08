//
//  PostDetailViewController.swift
//  producthunt
//
//  Created by Chung Tran on 08/12/2017.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import UIKit
import SDWebImage

class PostDetailViewController: UIViewController {

    var post: Post?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upvoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func reloadViews() {
        self.title = post?.name
        self.descriptionLabel.text = post?.description
        self.upvoteLabel.text = "\(post?.voteCount ?? 0) upvotes"
        self.imageView.sd_setImage(with: URL(string: post!.screenshot!)!, completed: nil)
        print(post!.screenshot!)
    }
    
    @IBAction func btnGetItTouched(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
