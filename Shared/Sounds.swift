
import AVFoundation

 class Sounds {

   static var audioPlayer:AVPlayer?

   static func playHttpSounds(soundfile: String) {

      

           do{
            if let url = URL(string: soundfile){
                let asset = AVAsset(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                audioPlayer = AVPlayer(playerItem: playerItem)
                audioPlayer?.automaticallyWaitsToMinimizeStalling = false;
                audioPlayer?.play()
                
            }

           }catch {
               print("Error")
           }
       
    }
 }
