//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Luc Derosne on 28/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    enum SortType: String {
        case name = "Name"
        case country = "Country"
        case unknow = ""
    }
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var sortType: SortType = .unknow
    @State private var sortedResort: [Resort] = [Resort]()
    @State private var isShowingSort = false
    @State private var isShowingFilter = false
    @State private var filterValue: String = ""
    
    var body: some View {
        NavigationView {
            List(sortedResort) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "hand.thumbsup.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(Color.green)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading:
                Button(action: {
                    self.isShowingSort = true
                }) {
                    Text("Sort")
                },
                                trailing: Button(action: {
                                    self.isShowingFilter = true
                                }) {
                                    Text("Filter")
                                    
            })
                .onAppear {
                    self.updateSortResorts()
            }
            .actionSheet(isPresented: $isShowingSort) {
                ActionSheet(title: Text("Sort type"), message: nil, buttons: [
                    .default(Text(SortType.name.rawValue), action: {
                        self.sortType = .name
                        self.updateSortResorts()
                    }),
                    .default(Text(SortType.country.rawValue), action: {
                        self.sortType = .country
                        self.updateSortResorts()
                    }),
                    .cancel()])
            }
            .sheet(isPresented: $isShowingFilter, onDismiss: updateSortResorts) {
                FilterView(resorts: self.resorts, filter: self.$filterValue)
            }
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
    }
    
    func updateSortResorts() {
        sortedResort = self.resorts
        if (sortType == .name) {
            sortedResort.sort { $0.name < $1.name }
        } else if (sortType == .country) {
            sortedResort.sort { $0.country < $1.country }
        }
        if !filterValue.isEmpty {
            sortedResort = sortedResort.filter{ $0.country == self.filterValue || String($0.size) == self.filterValue || String($0.price) == self.filterValue }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
