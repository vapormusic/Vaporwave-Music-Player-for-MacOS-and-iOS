//
//  SongDataPrefKey.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 03/12/2020.
//

import Foundation
import SwiftUI

struct SongDataPrefKey: PreferenceKey {
    typealias Value = SongData
    static var defaultValue: SongData = SongData(title: "Ew", album: "Nectar", artist: "Joji",  id: "2", url:  "http://lol" , arturl : "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png")
    
    static
    func reduce(value: inout SongData, nextValue: () -> SongData) {
        value = nextValue()
    }
}

