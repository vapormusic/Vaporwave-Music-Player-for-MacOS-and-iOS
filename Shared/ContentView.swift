//
//  ContentView.swift
//  Shared
//
//  Created by vaanh on 21/11/2020.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import AVFoundation



struct ContentView: View {
      
    @State var audioPlayer:AVPlayer?
    @State var albumarturl: String?
    @State var title: String?
    @State var artist: String?
    @State var songdata: SongData?
    @State var isPlaying : Bool = false
    @State var searchquery : String = "upgrade joji"
    @State var sizemultipler : Double = 1.2
    @State var mlist2 = MList(music_list: [])
    @State var mlistclass : MListClass = MListClass.init(MList: MList(music_list: []))
    @State var SearchList : SongList?
    @ObservedObject var songdataclass : SongDataClass
    @State var searchviewhide : Bool = false
    var body: some View {
        ZStack {
            
            
            
            AnimatedImage(url: URL(string: "https://i.imgur.com/eTm7oez.gif"))
            
            
            // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
            .onSuccess { image, data, cacheType in
                // Success
                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
            }
            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
        
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)// Activity Indicator
               
            .transition(.fade(duration: 0.5))// Fade Transition with duration
               
            .scaledToFill()
                .clipped()
                  //  .frame(width: 1024, height: 535 )
            
            
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
   
                WebImage(url: URL(string : "https://raw.githubusercontent.com/vapormusic/smalluploads/master/frameworkmac.png" ))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 269 * CGFloat(self.sizemultipler), height: 380 * CGFloat(self.sizemultipler)).clipped()
               
                VStack{
                    Spacer()
                        .frame(height: 42.0  * CGFloat(self.sizemultipler))
                    WebImage(url: URL(string: albumarturl ?? ""))
                    .resizable()
                  // .scaledToFit()
                
                    .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                   .padding(.top,44 * CGFloat(self.sizemultipler))
                   .padding(.leading,5 * CGFloat(self.sizemultipler))
                    .padding(.trailing,23 * CGFloat(self.sizemultipler))
                    .scaledToFill()
                    .frame(width: 269 * CGFloat(self.sizemultipler), height: 155 * CGFloat(self.sizemultipler))
                    .clipped()
                    
                    Spacer()
                        .frame(height: 10.0 * CGFloat(self.sizemultipler))
                    Text(title ?? "Title")
                        .font(Font.system(size: 15.5 ))
                        .padding(.leading,10 * CGFloat(self.sizemultipler))
                        .padding(.trailing,35 * CGFloat(self.sizemultipler))
                        .foregroundColor(.black)                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                        .frame(height: 3.0 * CGFloat(self.sizemultipler))
                    Text(artist ?? "Artist")
                        .font(Font.system(size: 12.0 ))
                        .padding(.leading,10 * CGFloat(self.sizemultipler))
                        .padding(.trailing,35 * CGFloat(self.sizemultipler))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.frame(width: 269 * CGFloat(self.sizemultipler), height: 380 * CGFloat(self.sizemultipler))
            
            VStack{
                Spacer()
                    .frame(height: 280.0 * CGFloat(self.sizemultipler))
                HStack()
                {
                    Button(action: {}) {
                        Text("").frame(width: 75.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)).padding(0)}.frame(width: 75.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)) .buttonStyle(BorderlessButtonStyle())
                    Button(action: {
                        

                        if (Sounds.isLoaded()){
                                if (Sounds.isPlaying()){
                                    Sounds.pause()
                                } else {Sounds.play()}
                        } else{
                                                    CSNGetter.getSongUrl(query: "all i want for christmas"){ result in
                            
                                                        print(result)
                                                    print("f")
                                                    self.albumarturl = result.arturl
                                                    self.artist = result.artist
                                                        self.title = result.title
                                                        Sounds.playHttpSounds(soundfile: result.url, songdata: result)
                            
                                                    }
                        }
                    }
                    
                    ) {
                       Text("").frame(width: 95.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)).padding(0)
                    }
                    .background(Color.clear)
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 95.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler))
                    Button(action: {}) {
                        Text("").frame(width: 95.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)).padding(0)
                        
                    }
                    .frame(width: 95.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler))
                    .buttonStyle(BorderlessButtonStyle())
                    
                }.frame(width: 269.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler))
                HStack{
                    Button(action: {}) {
                        Text("").frame(width:130.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)).padding(0)
                        
                    }
                    .frame(width: 130.5 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler))
                    
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Button(action: {
                        self.searchviewhide = false
                    }) {
                        Text("mode").frame(width: 120.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)).padding(0)
                        
                    }
                    .frame(width: 134.5 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler))
                    
                   .buttonStyle(BorderlessButtonStyle())
                    
                }.frame(width: 269.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler))
                
            }.frame(width: 269 * CGFloat(self.sizemultipler), height: 380 * CGFloat(self.sizemultipler))
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
                WebImage(url: URL(string : "https://raw.githubusercontent.com/vapormusic/smalluploads/master/frameworkmac.png" ))
                    
                    
                    
                    
                    
                    .resizable()
                    .scaledToFill()
                    .frame(width: 269 * CGFloat(self.sizemultipler), height: 380 * CGFloat(self.sizemultipler)).clipped()
                VStack(){
                    Button(action: {
                        self.searchviewhide = true
                    }) {
                        Text("").frame(width: 322 , height: 24.0 )
                        
                    }
                    .frame(width: 322, height: 24 )
                    
                   .buttonStyle(BorderlessButtonStyle())
                    Spacer()
                    .frame(width: 10.0, height: 24.0)
                    ZStack{
                    Rectangle()
                        .fill(Color.white)
                        VStack{
                            TextField("all i want for christmas", text: self.$searchquery, onCommit: {print(self.searchquery)
                                        CSNGetter.getSearchList(query: self.searchquery){result in
                                            self.mlistclass = MListClass.init(MList: result)
                                            print(self.mlistclass.MList.music_list[1])
                                            self.mlistclass.objectWillChange.send()}}).foregroundColor(.black)
                            Spacer()
                                .frame(height: 20.0)
                            
                            
//                            let x = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Upgrade", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id: 1)
//                            let y = MList.Song(music_album: "Nectar", music_artist: "Joji", music_title: "Ew", music_id: "1", cover_img: "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png", id:  2)
//
                           
                            SongList(userData: self.mlistclass)
                            
                        }.frame(height: 379).onAppear{
                            
                            CSNGetter.getSearchList(query: self.searchquery){result in
                                self.mlistclass = MListClass.init(MList: result)
                                print(self.mlistclass.MList.music_list[1])
                                self.mlistclass.objectWillChange.send()
                                
                                                          }
                            
                        }
                        
                        
                        
                    } .padding(.leading,5 * CGFloat(self.sizemultipler))
                        .padding(.trailing,23 * CGFloat(self.sizemultipler))
                        .padding(.bottom,24.5 * CGFloat(self.sizemultipler))
                    
                }
                
                
                
                
            }.frame(width: 269 * CGFloat(self.sizemultipler), height: 380 * CGFloat(self.sizemultipler))
            .onReceive(NotificationCenter.default.publisher(for: Notification.check))
            { obj in
                
                // Change key as per your "userInfo"
                if let userInfo = obj.userInfo {
                    self.searchviewhide = true
                    self.artist = userInfo["artist"] as? String
                    self.albumarturl = userInfo["arturl"] as? String
                    self.title = userInfo["title"] as? String
                    print(self.artist)
                    print("ok")
                }
            }
            .hidden(self.searchviewhide)
            
            
            
            
            
            
        }
 
      
        
    }
   
 
    
}

public func hello(link: String, songdata : SongData) {
    Sounds.playHttpSounds(soundfile: link,songdata: songdata)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(songdataclass: SongDataClass.init(SongData: SongData(title: "Ew", album: "Nectar", artist: "Joji",  id: "2", url:  "http://lol" , arturl : "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png")))
        
    }
    
    
}
