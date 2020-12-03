//
//  Vaporwave_Music_PlayerApp.swift
//  Shared
//
//  Created by vaanh on 21/11/2020.
//

import SwiftUI

@main
struct Vaporwave_Music_PlayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(songdataclass: SongDataClass.init(SongData: SongData(title: "Ew", album: "Nectar", artist: "Joji",  id: "2", url:  "http://lol" , arturl : "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png")))
            
        }
    }
}


