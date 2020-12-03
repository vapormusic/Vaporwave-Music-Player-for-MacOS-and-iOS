
import AVFoundation
import MediaPlayer
import SDWebImage
#if os(iOS)
import UIKit

#endif

 class Sounds {

   static var audioPlayer:AVPlayer?

    static func playHttpSounds(soundfile: String, songdata: SongData) {
    #if os(iOS)
     let audioSession = AVAudioSession.sharedInstance()
     let commandCenter = MPRemoteCommandCenter.shared()
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
                
                
                
                func setupRemoteTransportControls() {
                    commandCenter.pauseCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in

                         // Pause media
                        audioPlayer?.pause()
                        return .success
                     }

                     commandCenter.playCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in

                         // Play media
                        audioPlayer?.play()
                        return .success
                     }
                     
                     commandCenter.togglePlayPauseCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in
                         
                        if audioPlayer?.timeControlStatus == .playing {
                            audioPlayer?.pause()                 // Pause media
                         } else {
                             // Play media
                            audioPlayer?.play()             }

                         return .success
                     } }

          
                
                
                setupRemoteTransportControls()
                
                
                 func downloadImage(with url:String)  {
                    
                    SDWebImageDownloader.shared.downloadImage(with: URL(string: url),completed: {(image,data,error,true)  in
                        var nowPlayingInfo = [String : Any]()
                        
                            
                            nowPlayingInfo[MPMediaItemPropertyArtwork] = image
                    })
                 }
                func getData(from url: URL, completion: @escaping (UIImage?) -> Void) {
                     URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                         if let data = data {
                             completion(UIImage(data:data))
                         }
                     })
                         .resume()
                 }
                func setupNowPlaying(songinfo : SongData) {
                  
                    
                    SDWebImageDownloader.shared.downloadImage(with: URL(string: songinfo.arturl),completed: {(image,data,error,true)  in
                       
                        var nowPlayingInfo = [String : Any]()
                        nowPlayingInfo[MPMediaItemPropertyTitle] = songinfo.title
                        nowPlayingInfo[MPMediaItemPropertyArtist] = songinfo.artist
                        do {
                        
                            let artwork = MPMediaItemArtwork.init(boundsSize: image?.size ?? CGSize(), requestHandler: { _ -> UIImage in
                                return (image ?? UIImage())
                                
                            }
                            
                            )
                            
                            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                        }
                        catch {}
                        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                    })
                     
                }
                
                setupNowPlaying(songinfo: songdata)
                #endif
                
            }

           }catch {
               print("Error")
           }
       
    }
    
  
    #if os(iOS)
   
    
    #endif

 }


