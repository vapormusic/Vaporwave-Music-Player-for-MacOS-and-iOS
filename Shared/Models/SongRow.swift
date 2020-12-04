//
//  SongRow.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 01/12/2020.
//

import Foundation
import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct SongRow: View {
    @State var songdata : SongData = SongData(title: "Ew", album: "Nectar", artist: "Joji",  id: "2", url:  "http://lol" , arturl : "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png")
    var landmark: MList.Song

    var body: some View {
        ZStack{
        HStack(alignment: .center) {
            
            WebImage(url : URL(string: landmark.cover_img))
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 32, height: 32)
                .fixedSize(horizontal: true, vertical: false)
                .cornerRadius(4.0)

            VStack(alignment: .leading) {
                Text(landmark.music_title)
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text(landmark.music_artist)
                    .font(.caption)
                    .opacity(0.625)
                    .truncationMode(.middle)
                    .foregroundColor(.black)
                    .lineLimit(1)
            }

            Spacer()

    
        }.background(Color.white).frame(width: 250, height: 32)
            
            Button(action: {
                CSNGetter.getSongInfo(music_id: landmark.music_id){  result in
                    hello(link : result.url, songdata : result)
                    self.songdata = result
                    NotificationCenter.default.post(name: Notification.check, object: nil, userInfo: ["arturl": result.arturl, "artist": result.artist, "title" : result.title]
                    )
                    
                }
            }) {
                Rectangle().fill(Color.clear).frame(width: 260, height: 32)
                
            }.buttonStyle(BorderlessButtonStyle()).background(Color.clear).frame(width: 260, height: 32)
            
        }
      
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(landmark: MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Upgrade", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id: 1))
    }
}
