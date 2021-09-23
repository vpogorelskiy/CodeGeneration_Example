//
//  ContentView.swift
//  Shared
//
//  Created by Вячеслав Погорельский on 20.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CustomNavigation.NavigationView() {
                VStack{
                    Text("Nothing to see here yet")
                        .navigationTitle("Title")
                    Spacer().frame(height: 44)
                    NavigationLink("Go Custom way", destination: Text("Navigated to custom view"))
                }
            }.tabItem { Text("Custom") }
            
            NavigationView {
                NavigationLink("Push natively",
                               destination: Text("Native child"))
                    .navigationTitle("Native navigation")
            }.tabItem { Text("Native") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
