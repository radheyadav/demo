//
//  YoutubevideoPlayer.swift
//  demo
//
//  Created by CMTech on 13/4/22.
//

import UIKit
import YoutubeKit

class YoutubevideoPlayer: UIViewController {
    private var player : YTSwiftyPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 0, width: 640, height: 480), playerVars: [.playsInline(true),.videoID(APIList.WebServices.youtubeVideoID)         ])
        player.autoplay = true
        view = player
        
        player.loadPlayer()
    }
    
    
    
}
