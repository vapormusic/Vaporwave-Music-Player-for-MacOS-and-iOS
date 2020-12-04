//
//  SongList.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 01/12/2020.
//

import Foundation
import SwiftUI



struct SongList: View {
    
    @ObservedObject var userData: MListClass
    
    var body: some View {
//        let x = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Upgrade", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id: 1)
//        let y = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Ew", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id:  2)
        ZStack{
            Rectangle().fill(Color.white)
        let mlist = userData.MList
        List {
            ForEach(mlist.music_list) { music in
                
                SongRow(landmark: mlist.music_list[(music.id - 1) ])
                
                
            }
            
        }.background(Color.white)
        
           

   
        }
    }
    
    
}


struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        let x = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Upgrade", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id: 1)
        let y = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Ew", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id:  2)
      var mlist = MList(music_list: [x,y])
        var mlistclass = MListClass.init(MList: mlist)
        SongList(userData: mlistclass)

        VStack{}.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(2)) {
              
                        let x1 = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Upgrade 1", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id: 1)
            let y1 = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Ew 2", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id:  2)
             mlist = MList(music_list: [x1,y1])
            mlistclass = MListClass.init(MList: mlist)
            }}
    }
}
