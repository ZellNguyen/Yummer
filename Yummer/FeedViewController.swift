//
//  FeedViewController.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-26.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkDelegate {

    var feedViewModel = FeedViewModel()
    
    @IBOutlet var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        feedViewModel.delegate = self
        feedViewModel.fetch()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = feedTableView.dequeueReusableCell(withIdentifier: "FeedTableCell") as! FeedTableCell
        let post = feedViewModel.feed[indexPath.row]
        
        guard post.friend != nil else { return UITableViewCell() }
        feedCell.friendName.text = post.friend?.name
        
        guard post.rids != nil else { return UITableViewCell() }
        feedCell.pickedItems.text = "is interested in \((post.rids?.count)!) places"
        
        guard post.lastActive != nil else { return UITableViewCell() }
        feedCell.lastActive.text = post.lastActive!.toString()
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.feed.count
    }

    func onRetrieved(resultAtIndex index: Int) {
        self.feedTableView.reloadData()
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
