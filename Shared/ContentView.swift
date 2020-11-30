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
    @State var sizemultipler : Double = 1.2
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
            .indicator(.activity)// Activity Indicator
               
            .transition(.fade(duration: 0.5))// Fade Transition with duration
            .scaledToFill()
                .clipped()
            
            
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
                    .frame(height: 250.0 * CGFloat(self.sizemultipler))
                HStack()
                {
                    Button(action: {}) {
                        Text("").frame(width: 75.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)).padding(0)}.frame(width: 75.0 * CGFloat(self.sizemultipler), height: 32.0 * CGFloat(self.sizemultipler)) .buttonStyle(BorderlessButtonStyle())
                    Button(action: {
                        CSNGetter.getSongUrl(query: "upgrade joji"){ result in
                            
                            print(result)
                        print("f")
                        self.albumarturl = result.arturl
                        self.artist = result.artist
                            self.title = result.title
                            Sounds.playHttpSounds(soundfile: result.url)
                            
                        }
                        
                        
                    }) {
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
    

            }.frame(width: 269 * CGFloat(self.sizemultipler), height: 380 * CGFloat(self.sizemultipler))
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
