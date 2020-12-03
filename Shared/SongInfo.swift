//
//  SongInfo.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 03/12/2020.
//

import Foundation


struct SongInfo : Decodable{
    let code: Int
    let data: SongDatas
    
    struct SongDatas : Decodable {
        let music: SongDetailed
    }
    
    struct SongDetailed: Decodable {
    let music_album: String?
    let music_artist: String?
    let music_title: String?
    let music_id: String?
    let cover_image : String?
    let file_urls : [SongLinks]?
    }
    
    struct SongLinks : Decodable {
        let url: String
    }
    
    
}

class SongInfoClass : ObservableObject{
   @Published var SongInfo : SongInfo
    
    init(SongInfo : SongInfo) {
        self.SongInfo = SongInfo
        
    }
    
    
}
