//
//  ContentView.swift
//  ModernPracticeScrollView
//
//  Created by Papon Supamongkonchai on 30/4/2567 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

//#Preview {
//    ContentView()
//}
