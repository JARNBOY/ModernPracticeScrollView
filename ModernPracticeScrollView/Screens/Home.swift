//
//  Home.swift
//  ModernPracticeScrollView
//
//  Created by Papon Supamongkonchai on 30/4/2567 BE.
//

import SwiftUI

struct Home: View {
    // View Properties
    @State private var searchText: String = ""
    @State private var activeTab: Tab = .all
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15, content: {
                DummyMessagesView()
            })
            .safeAreaPadding(15)
            .safeAreaInset(edge: .top, spacing: 0) {
                ExpandableNavigationBar()
            }
        }
        .background(
            .gray.opacity(0.15)
        )
    }
    
    // Expandable Navigation Bar
    @ViewBuilder
    func ExpandableNavigationBar(_ title: String = "Messages") -> some View {
        VStack(spacing: 10, content: {
            /// Title
            Text(title)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            /// Search Bar
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                
                TextField("Search Conversation", text: $searchText)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .frame(height: 45)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.background)
            )
            
            /// Custom Segmented Picker
            ScrollView(.horizontal) {
                HStack(spacing: 12, content: {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        Button(action: {
                            withAnimation(.snappy) {
                                activeTab = tab
                            }
                        }, label: {
                            if activeTab == tab {
                                Text(tab.rawValue)
                                    .font(.callout)
                                    .foregroundStyle((scheme == .dark ? .black : . white))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .background(
                                        Capsule()
                                            .fill(Color.primary)
                                    )
                            } else {
                                Text(tab.rawValue)
                                    .font(.callout)
                                    .foregroundStyle(Color.primary)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .background(
                                        Capsule()
                                            .fill(.background)
                                    )
                            }
                        })
                        .buttonStyle(.plain)
                    }
                })
            }
            .frame(height: 50)
        })
        .padding(.top, 25)
        .safeAreaPadding(.horizontal, 15)
        .padding(.bottom, 10)
    }

    // Dummy Messages View
    @ViewBuilder
    func DummyMessagesView() -> some View {
        ForEach(1..<20, id: \.self) { count in
            HStack(spacing: 12, content: {
                
                Circle()
                    .frame(width: 55, height: 55)
                
                VStack(alignment: .leading, spacing: 6, content: {
                    Rectangle()
                        .frame(width: 140, height: 8)
                    
                    Rectangle()
                        .frame(height: 8)
                    
                    Rectangle()
                        .frame(width: 80, height: 8)
                })
            })
            .foregroundStyle(.gray.opacity(0.4))
            .padding(.horizontal, 15)
        }
    }
    
}

//#Preview {
//    Home()
//}
