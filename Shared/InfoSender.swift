//
//  InfoSender.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 03/12/2020.
//

import Foundation
import SwiftUI

extension Notification {
    static let check = Notification.Name.init("ok")
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
