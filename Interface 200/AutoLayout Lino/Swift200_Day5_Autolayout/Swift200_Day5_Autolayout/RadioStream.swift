//
//  RadioStream.swift
//  Swift200_Day5_Autolayout
//
//  Created by Swift on 16/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class RadioStream {
    
    enum Station {
        case rock 
        case pop
        case ecletic
        case dance
    }
    
    private var player:AVPlayer?        
    var currentStation:Station?      //Station atual
    
    var isPlaying:Bool {              
        get{
            return player != nil
        }
        set{
            if newValue == true {
                change(toStation: currentStation ?? .rock)
            }else {
                player?.pause() 
                player = nil
            }
        }
    }    
    
    func change(toStation station:Station) {
        
        let radioAddress:String
        let stationName:String
        currentStation = station
        
        switch station {
            case .rock:
                radioAddress = "http://streaming.shoutcast.com/89FMARADIOROCK"
                stationName = "Rock (89 FM)"    
            case .pop:
                radioAddress = "http://antena1.newradio.it/stream?1475840621661.acc"
                stationName = "Pop (Antena 1)"    
            case .ecletic:
                radioAddress = "http://200.144.185.21:8007/radiousp-128.mp3"
                stationName = "Ecletic (Radio USP)"
            case .dance:
                radioAddress = "http://aac.97fm.com.br:80/energia"
                stationName = "Dance (Energia FM)"
        }
        
        if let playbackURL = URL(string:radioAddress) {
            //Confgurando para tocar em Background
           let session = AVAudioSession.sharedInstance()
           try? session.setCategory(AVAudioSessionCategoryPlayback)
            
            //Adicionando na central de controle
           let artSize = CGSize(width:340, height:340)
           let artWork = MPMediaItemArtwork(boundsSize: artSize,
                                             requestHandler: { _ in 
                                                return UIImage(named: "icone_original") ?? UIImage()   
           })
            
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [
                MPMediaItemPropertyTitle: stationName,
                MPMediaItemPropertyArtist: "Quadrática",
                MPNowPlayingInfoPropertyIsLiveStream: true,
                
                MPMediaItemPropertyArtwork: artWork
            ]
            
            player = AVPlayer(url: playbackURL)
            player?.play()
        }
        
    }
    
}
