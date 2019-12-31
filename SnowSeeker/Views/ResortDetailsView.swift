//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Luc Derosne on 29/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//
import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort

    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var body: some View {
        Group {
            Text("Elevation: \(resort.elevation)m").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Snow: \(resort.snowDepth)cm").layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static let resort = Resort.example
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}

