//
//  View+Extension.swift
//  SnowSeeker
//
//  Created by Luc Derosne on 30/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
