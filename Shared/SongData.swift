//
//  SongData.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 29/11/2020.
//

import Foundation

public struct SongData : Codable {
    var title: String
    var album: String?
    var artist: String
    var id: String
    var url : String
    var arturl : String
}
