//
//  MPVolumeView.swift
//  Little Agent
//
//  Created by edwin weru on 26/01/2021.
//

import Foundation
import MediaPlayer

// extension MPVolumeView {
//    var volumeSlider:UISlider {
//        self.showsRouteButton = false
//        self.showsVolumeSlider = false
//        self.hidden = true
//        var slider = UISlider()
//        for subview in self.subviews {
//            if subview.isKindOfClass(UISlider){
//                slider = subview as! UISlider
//                slider.continuous = false
//                (subview as! UISlider).value = AVAudioSession.sharedInstance().outputVolume
//                return slider
//            }
//        }
//        return slider
//    }
// }

// Update system volume
extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        // volumeView.showsVolumeSlider = false

        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
