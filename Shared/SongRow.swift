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
    var landmark: MList.Song

    var body: some View {
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

                Text(landmark.music_artist)
                    .font(.caption)
                    .opacity(0.625)
                    .truncationMode(.middle)
            }

            Spacer()

    
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(landmark: MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Upgrade", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id: 1))
    }
}
