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
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
            Image("frameworkmac")
               
                VStack{
                    Spacer()
                        .frame(height: 40.0)
                WebImage(url: URL(string:"https://images.genius.com/79c6343980b4513f2c46813301da0dec.300x300x1.png"))
                    .resizable()
                  // .scaledToFit()
                
                    .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                   .padding(.top,40)
                   .padding(.leading,4)
                    .padding(.trailing,23)
                    .scaledToFill()
                    .frame(width: 269, height: 157)
                    .clipped()
                    
                    
           
                
                }
            }.frame(width: 269, height: 380)
            Spacer()
            Button(action: {
               //  Sounds.playSounds(soundfile: "a.wav")
                Sounds.playHttpSounds(soundfile: "https://data35.chiasenhac.com/downloads/1954/0/1953381-6ce0e25f/128/Slow%20Dancing%20In%20The%20Dark%20-%20Joji.mp3")

            }) {}
            .padding(.bottom, 30.0)
            .frame(width: 10.0, height: 52.0)
    

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
