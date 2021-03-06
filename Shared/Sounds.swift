
import AVFoundation
import MediaPlayer
import SDWebImage
#if os(iOS)
import UIKit

#endif

 class Sounds {

   static var audioPlayer:AVPlayer?
    

    
    static func play(){
        audioPlayer?.play()
        
    }
    
    static func pause(){
        audioPlayer?.pause()
    }
    
    static func isPlaying() -> Bool {
        if ((audioPlayer?.rate != 0) && (audioPlayer?.error == nil)) {
            // player is playing
            return true
        } else {return false}
    }
    
    static func isLoaded() -> Bool {
        print("rate:\(audioPlayer?.rate != nil)")
        if ((audioPlayer?.rate != nil)) {
            // player is playing
            
            return true
        } else {return false}
        
        
    }

    static func playHttpSounds(soundfile: String, songdata: SongData) {
        
        
        var ptime: CMTime = CMTime()
        var seektimechanged : Bool = true
        let commandCenter = MPRemoteCommandCenter.shared()
        #if os(iOS)
     let audioSession = AVAudioSession.sharedInstance()
     
    #endif

           do{
            if let url = URL(string: soundfile){
                let asset = AVAsset(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                audioPlayer = AVPlayer(playerItem: playerItem)
                audioPlayer?.automaticallyWaitsToMinimizeStalling = false;
                audioPlayer?.play()
                
                
                #if os(iOS)
                do {
                    let recordingSession = AVAudioSession.sharedInstance()
                    try recordingSession.setCategory(.playback, mode: .default)
                            try recordingSession.setActive(true)
                        } catch {
                            print("Failed to set up recording session")
                        }
                do{ try AVAudioSession.sharedInstance().setActive(true)}catch{}
                UIApplication.shared.beginReceivingRemoteControlEvents()
                #endif
                
     
                
                
//                 func downloadImage(with url:String)  {
//
//                    SDWebImageDownloader.shared.downloadImage(with: URL(string: url),completed: {(image,data,error,true)  in
//                        var nowPlayingInfo = [String : Any]()
//
//
//                            nowPlayingInfo[MPMediaItemPropertyArtwork] = image
//                    })
//                 }
//                func getData(from url: URL, completion: @escaping (UIImage?) -> Void) {
//                     URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
//                         if let data = data {
//                             completion(UIImage(data:data))
//                         }
//                     })
//                         .resume()
//                 }
                func setupNowPlaying(songinfo : SongData, paused : Bool, pausedtime : CMTime) {
                  
                    
                    SDWebImageDownloader.shared.downloadImage(with: URL(string: songinfo.arturl),completed: {(image,data,error,true)  in
                       
                        var nowPlayingInfo = [String : Any]()
                        nowPlayingInfo[MPMediaItemPropertyTitle] = songinfo.title
                        nowPlayingInfo[MPMediaItemPropertyArtist] = songinfo.artist
                        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = CMTimeGetSeconds(playerItem.asset.duration)
                        if(paused == true){
                            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(pausedtime)
                            
                        }else{
                            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(playerItem.currentTime())}
                        print(CMTimeGetSeconds(playerItem.asset.duration))
                        #if os(iOS)
                        do {
                          
                            let artwork = MPMediaItemArtwork.init(boundsSize: image?.size ?? CGSize(), requestHandler: { _ -> UIImage in
                                return (image ?? UIImage())
                            }
                            )
                            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                            
                        }
                        catch {}
                        #endif
                        #if os(macOS)
                        do {
                            let artwork = MPMediaItemArtwork.init(boundsSize: image?.size ?? CGSize(), requestHandler: { _ -> NSImage in
                                return (image ?? NSImage())
                            }
                            )
                            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                            
                        }
                        catch {}
                        #endif
                        
                        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                    })
                     
                }
                DispatchQueue.main.async {
                    setupNowPlaying(songinfo: songdata, paused: false, pausedtime: CMTime())}
                
                func changetime(time :CMTime){
                   
                    MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(time)
                }
                
               
                func setupRemoteTransportControls() {
                    commandCenter.pauseCommand.addTarget { event -> MPRemoteCommandHandlerStatus in

                         // Pause media
                       print("timebefore : \(CMTimeGetSeconds(playerItem.currentTime()))")
                         
                        audioPlayer?.pause()
                        let ptime2 = playerItem.currentTime()
              
                            if(!seektimechanged){
                                changetime(time: ptime)
                                seektimechanged = true
                  
                            }
                            print("timebefore2 : \(CMTimeGetSeconds(ptime2))")
                            ptime = ptime2
                            seektimechanged = false
                            
                        
                        #if os(macOS)
                        MPNowPlayingInfoCenter.default().playbackState = .paused
                        #endif
                        
                        return .success
                     }

                     commandCenter.playCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in
                                                 // Play media
                        print(ptime)
                  
                            if(!seektimechanged){
                            changetime(time: ptime)
                                seektimechanged = true
                                
                            }
                        
                        audioPlayer?.play()
                        #if os(macOS)
                        MPNowPlayingInfoCenter.default().playbackState = .playing
                        #endif
                        return .success
                     }
                     
                    commandCenter.changePlaybackPositionCommand.isEnabled = true
                    commandCenter.changePlaybackPositionCommand.addTarget { event -> MPRemoteCommandHandlerStatus in
                        let event = event as! MPChangePlaybackPositionCommandEvent
                        ptime = CMTimeMakeWithSeconds(event.positionTime,preferredTimescale: 1000)
                        seektimechanged = false
                        audioPlayer?.seek(to: CMTimeMakeWithSeconds(event.positionTime,preferredTimescale: 1000))
                        
                        return .success
                    }
                    commandCenter.togglePlayPauseCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in
                         
                        if audioPlayer?.timeControlStatus == .playing {
                            audioPlayer?.pause()
                            // Pause media
                            #if os(macOS)
                            MPNowPlayingInfoCenter.default().playbackState = .paused
                            #endif
                            
                        } else {
                             // Play media
                            #if os(macOS)
                            MPNowPlayingInfoCenter.default().playbackState = .playing
                            #endif
                            audioPlayer?.play()
                            
                         }

                         return .success
                     }
                    #if os(macOS)
                    MPNowPlayingInfoCenter.default().playbackState = .playing
                    #endif
                    
                }

          
                
                
                setupRemoteTransportControls()
                
             
                
                
                
                
                
            }
            

           }catch {
               print("Error")
           }
       
    }
    
  
    #if os(iOS)
   
    
    #endif

 }


