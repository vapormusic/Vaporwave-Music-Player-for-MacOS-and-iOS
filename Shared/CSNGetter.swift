//
//  CSNGetter.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 29/11/2020.
//

import Foundation
import Alamofire

class CSNGetter{
    

    
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
    static func getSongUrl(query: String, completion: @escaping (SongData) -> Void)  {
      
        var songid : String
        var title = ""
        var album = ""
        var artist = ""
        var id = ""
        var url = ""
        var arturl = ""
        let parameters: Parameters = [
             //  "q": query
            "s" : query
               ]
       // let z = "https://chiasenhac.vn/api/search?row=1"
        let searchurl = "http://search.nhacgoc.com/api/search.php?code=csn22052018&row=1"
        let songurl = "https://chiasenhac.vn/api/listen_info_music"
        
        AF.request(searchurl,
                   method: .get,
                   parameters: parameters
        ).response { response in
            
            let result = response.data
            
            do {
                print(response)
                let   songs = try JSONDecoder().decode(MList.self, from: result!)
                let musicid = songs.music_list[0].music_id
                print(songs.music_list[0].music_id)
                
                
                let parameters2: Parameters = [
                     //  "q": query
                    "music_id" : musicid,
                    "type" : "music"
                       ]
                AF.request(songurl,
                           method: .post,
                          parameters: parameters2
                ).response{ response in
                    
                   let result = response.data
                   // print(response)
                   do {
                       let   song = try JSONDecoder().decode(SongInfo.self, from: result!)
                    print(song.data.music.file_urls?[1].url ?? "" )
                    
                     title = song.data.music.music_title ?? ""
                    
                        album = song.data.music.music_album ?? ""
                     artist = song.data.music.music_artist ?? ""
                     id = song.data.music.music_id ?? ""
                    url = song.data.music.file_urls?[1].url ?? ""
                     arturl = song.data.music.cover_image ?? ""
                    
                    completion(SongData(title: title, album: album, artist: artist, id: id, url: url, arturl: arturl))
                    
                   } catch{
                    print(error)
                   }
                        
                    }
             
                
                
            } catch {
             print(error)
            print("Error")
            print("Oh no")
                
            }
            
     
            
        }
      
        
    //    print(title)
    
     //   return SongData(title: title, album: album, artist: artist, id: id, url: url, arturl: arturl)
        
    }
    
    static func getSearchList(query: String, completion: @escaping (MList) -> Void){
        let searchurl = "http://search.nhacgoc.com/api/search.php?code=csn22052018&row=1"
        let parameters: Parameters = [
             //  "q": query
            "s" : query
               ]
        
        
        
        AF.request(searchurl,
                   method: .get,
                   parameters: parameters
        ).response { response in
            
            let result = response.data
            
            do {
                print(response)
                let   songs = try JSONDecoder().decode(MList.self, from: result!)
                completion(songs)
                
            }
            catch{
                print(error)
            }
    }
    
    }
    
    static func getSongInfo(music_id : String, completion: @escaping (SongData) -> Void)
    {
        let songurl = "https://chiasenhac.vn/api/listen_info_music"
        var title = ""
        var album = ""
        var artist = ""
        var id = ""
        var url = ""
        var arturl = ""
        let parameters2: Parameters = [
             //  "q": query
            "music_id" : music_id,
            "type" : "music"
               ]
        AF.request(songurl,
                   method: .post,
                  parameters: parameters2
        ).response{ response in
            
           let result = response.data
           // print(response)
           do {
               let   song = try JSONDecoder().decode(SongInfo.self, from: result!)
            print(song.data.music.file_urls?[1].url ?? "" )
            
             title = song.data.music.music_title ?? ""
            
                album = song.data.music.music_album ?? ""
             artist = song.data.music.music_artist ?? ""
             id = song.data.music.music_id ?? ""
            url = song.data.music.file_urls?[1].url ?? ""
             arturl = song.data.music.cover_image ?? ""
            
            completion(SongData(title: title, album: album, artist: artist, id: id, url: url, arturl: arturl))
            
           } catch{
            print(error)
           }
                
            }
        
    }
    
}
