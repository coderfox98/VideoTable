//
//  VideosTableViewController.swift
//  VideoTable
//
//  Created by Rish on 17/10/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideosTableViewController : UITableViewController {
    
    var videos : [Video] = Video.fetchVideos()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    //MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        let video = videos[indexPath.row]
        cell.video = video
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo(at : indexPath)
    }
    
    func playVideo(at indexPath : IndexPath) {
        let selectedVideo = videos[indexPath.row]
        let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4")
        let videoPathURL = URL(fileURLWithPath: videoPath ?? "")
        player = AVPlayer(url: videoPathURL)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // animation 1
//        let rotationAnimation = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//        cell.layer.transform = rotationAnimation
//        cell.alpha = 0.3
//
//        UIView.animate(withDuration: 0.7) {
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1
//        }
        
        let rotationAnimation = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationAnimation
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.75) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
        
    }
    
}
