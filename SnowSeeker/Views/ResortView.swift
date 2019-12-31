//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Luc Derosne on 29/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    var resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var selectedFacility: Facility?
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading , spacing: 20){
                GeometryReader{ geometry in
                    Group{
                        if geometry.frame(in: .global).minY <= 0{
                            Image(decorative:self.resort.id)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width , height: geometry.size.height)
                                .offset(y: geometry.frame(in: .global).minY/9)
                                .clipped()
                            Text(self.resort.imageCredit)
                                .font(.footnote)
                                .italic()
                        }else {
                            Image(self.resort.id)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width , height: geometry.size.height + geometry.frame(in: .global).minY)
                                .clipped()
                                .offset(y: -geometry.frame(in: .global).minY)
                            Text(self.resort.imageCredit)
                            .font(.footnote)
                            .italic()
                        }
                    }
                }
                .frame(height: 400)
                
                HStack{
                    if sizeClass == .compact {
                        Spacer()
                        VStack{ResortDetailsView(resort: resort)}
                        VStack{SkiDetailsView(resort: resort)}
                        Spacer()
                    }else{
                        ResortDetailsView(resort: resort)
                        Spacer().frame(height: 2)
                        SkiDetailsView(resort: resort)
                    }
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                
                
                Group{
                    Text(resort.description)
                        .padding()
                    
                    Text("Facilities")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack{
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.horizontal)
            }
            
            
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
            
        }
        .alert(item: $selectedFacility, content: { (facility) -> Alert in
            facility.alert
        })
        .navigationBarTitle("\(resort.name) , \(resort.country)" , displayMode: .inline)
            
            ///Adds a button to mark a resort as favorite
            .navigationBarItems(trailing: Button(action: {
                if self.favorites.contains(self.resort){
                    self.favorites.remove(self.resort)
                }else{
                    self.favorites.add(self.resort)
                }
            }){
                Image(systemName: self.favorites.contains(self.resort) ? "hand.thumbsup" : "hand.thumbsup.fill")
                    .foregroundColor(self.favorites.contains(self.resort) ? Color.green : Color.gray)
                    .font(.title)
            })
    }
}

struct ResortView_Previews: PreviewProvider {
    static let resort = (Bundle.main.decode("resorts.json")  as [Resort])[0]
    static var previews: some View {
        ResortView(resort: self.resort)
    }
}
