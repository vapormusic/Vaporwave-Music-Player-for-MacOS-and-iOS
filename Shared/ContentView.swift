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

     @State var isPlaying : Bool = false
    var body: some View {
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
        
        
        
    
        Button(action: {
           //  Sounds.playSounds(soundfile: "a.wav")
            Sounds.playHttpSounds(soundfile: "https://data35.chiasenhac.com/downloads/1954/6/1953381-6ce0e25f/128/Slow%20Dancing%20In%20The%20Dark%20-%20Joji.mp3")

        }) {
            HStack {
                Image(systemName: "trash")
                    .font(.title)
                Text("Delete")
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
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
