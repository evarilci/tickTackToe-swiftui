//
//  ContentView.swift
//  shadowView
//
//  Created by Eymen Varilci on 7.07.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        NavigationView{
        gridView()
                .navigationTitle("Tick Tack Toe")
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
