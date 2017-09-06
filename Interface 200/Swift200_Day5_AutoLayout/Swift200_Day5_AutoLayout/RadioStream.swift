//
//  RadioStream.swift
//  Swift200_Day5_AutoLayout
//
//  Created by Swift on 02/09/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import Foundation
import AVFoundation

class RadioStream {

  enum Station {
    case rock
    case pop
    case ecletic
    case dance
  }
  
  var player:AVPlayer?
  
  func change(toStation station:Station) {
    
    let radioAddress:String
    
    switch station {
     case .rock:
       radioAddress = "http://streaming.shoutcast.com/89FMARADIOROCK"
     case .pop:
       radioAddress = "http://antena1.newradio.it/stream?1475840621661.acc"
     case .ecletic:
       radioAddress = "http://200.144.185.21:8007/radiousp-128.mp3"
     case .dance:
       radioAddress = "http://aac.97fm.com.br:80/energia"
    }
    
    if let playbackURL = URL(string: radioAddress) {
      player = AVPlayer(url: playbackURL)
      player?.play()
    }
  }
}
