//
//  SongData.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 29/11/2020.
//

import Foundation

public struct SongData : Codable, Equatable {
    var title: String
    var album: String?
    var artist: String
    var id: String
    var url : String
    var arturl : String
}

class SongDataClass : ObservableObject{
   @Published var SongData : SongData
    
    init(SongData : SongData) {
        self.SongData = SongData
        
    }
    
    
}
