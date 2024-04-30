//
//  Home.swift
//  ModernPracticeScrollView
//
//  Created by Papon Supamongkonchai on 30/4/2567 BE.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15, content: {
                ForEach(1...10, id: \.self) { count in
                    /*@START_MENU_TOKEN@*/Text("Placeholder \(count)")/*@END_MENU_TOKEN@*/
                }
            })
            .safeAreaPadding(15)
            .safeAreaInset(edge: .top, spacing: 0) {
                
            }
        }
    }
    
    
}

//#Preview {
//    Home()
//}
