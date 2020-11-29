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
    
     @State var isPlaying : Bool = false
    var body: some View {
        ZStack {
            
          
            
            AnimatedImage(url: URL(string: "https://i.pinimg.com/originals/16/69/e5/1669e57761ccc67fa5e31a09a54764d0.gif"))
            
            
            // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
            .onSuccess { image, data, cacheType in
                // Success
                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
            }
            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
            
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5))// Fade Transition with duration
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
            Image("frameworkmac")
               
                VStack{
                    Spacer()
                        .frame(height: 42.0)
                    WebImage(url: URL(string: albumarturl ?? ""))
                    .resizable()
                  // .scaledToFit()
                
                    .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                   .padding(.top,44)
                   .padding(.leading,5)
                    .padding(.trailing,23)
                    .scaledToFill()
                    .frame(width: 269, height: 155)
                    .clipped()
                    
                    Spacer()
                        .frame(height: 10.0)
                    Text(title ?? "Title")
                        .font(Font.system(size: 15.5))                  .padding(.leading,10)
                        .padding(.trailing,35)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                        .frame(height: 3.0)
                    Text(artist ?? "Artist")
                        .font(Font.system(size: 12.0))
                        .padding(.leading,10)
                        .padding(.trailing,35)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.frame(width: 269, height: 380)
            
            VStack{
                Spacer()
                    .frame(height: 250.0)
                HStack()
                {
                    Button(action: {}) {
                        Text("").frame(width: 75.0, height: 32.0).padding(0)}.frame(width: 75.0, height: 32.0) .buttonStyle(BorderlessButtonStyle())
                    Button(action: {
                        
                self.albumarturl = "https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png"
               //  Sounds.playSounds(soundfile: "a.wav")
                Sounds.playHttpSounds(soundfile: "https://data35.chiasenhac.com/downloads/1954/0/1953381-6ce0e25f/128/Slow%20Dancing%20In%20The%20Dark%20-%20Joji.mp3")
                        CSNGetter.getSongUrl(query: "ew")
                        
                    }) {
                       Text("").frame(width: 95.0, height: 32.0).padding(0)
                    }
                    .background(Color.clear)
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 95.0, height: 32.0)
                    Button(action: {}) {
                        Text("").frame(width: 95.0, height: 32.0).padding(0)
                        
                    }
                    .frame(width: 95.0, height: 32.0)
                    .buttonStyle(BorderlessButtonStyle())
                    
                }.frame(width: 269.0, height: 32.0)
    

            }.frame(width: 269, height: 380)
        }
 
      
        
    }
    
    
}

func video() {
   }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
    
    
}
