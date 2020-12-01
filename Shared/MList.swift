//
//  MList.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 01/12/2020.
//

import Foundation

struct MList : Decodable {
    let music_list : [Song]
    
    struct Song: Decodable{

        
    let music_album: String
    let music_artist: String
    let music_title: String
    let music_id: String
    let cover_img : String
    let id : Int
    }
    
}

extension MList: Identifiable {
    var id: Int { return 1 }
}

extension MList.Song : Identifiable {
    var id2 : Int { return 2 }
}

class MListClass : ObservableObject{
   @Published var MList : MList 
    
    init(MList : MList) {
        self.MList = MList
        
    }
    
    func getMList() -> MList {
         
         return MList
     }
    
}
