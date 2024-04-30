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
    @FocusState private var isSearching: Bool
    @State private var activeTab: Tab = .all
    @Environment(\.colorScheme) private var scheme
    @Namespace private var animation
    
    private let heightEapandedBar = 190.0
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15, content: {
                DummyMessagesView()
            })
            .safeAreaPadding(15)
            .safeAreaInset(edge: .top, spacing: 0) {
                ExpandableNavigationBar()
            }
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: isSearching)
        }
        .scrollTargetBehavior(CustomScrollTargetBehaviour())
        .background(
            .gray.opacity(0.15)
        )
    }
    
    // Expandable Navigation Bar
    @ViewBuilder
    func ExpandableNavigationBar(_ title: String = "Messages") -> some View {
        GeometryReader(content: { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let fasterTheScrollAnimationValue = 70.0
            let scrollViewHeight = proxy.bounds(of: .scrollView(axis: .vertical))?.height ?? 0
            let scaleProgress = minY > 0 ? 1 + (max(min(minY / scrollViewHeight, 1), 0) * 0.5) : 1
            let progress = isSearching ? 1 : max(min( -minY / fasterTheScrollAnimationValue, 1), 0)
            
            VStack(spacing: 10, content: {
                /// Title
                Text(title)
                    .font(.largeTitle.bold())
                    .scaleEffect(scaleProgress, anchor: .topLeading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                
                /// Search Bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                    
                    TextField("Search Conversation", text: $searchText)
                        .focused($isSearching)
                    
                    if isSearching {
                        Button(action: {
                            isSearching = false
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                        })
                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                    }
                }
                .foregroundStyle(Color.primary)
                .padding(.vertical, 10)
                .padding(.horizontal, 15 - (progress * 15))
                .frame(height: 45)
                .clipShape(.capsule)
                .background(
                    RoundedRectangle(cornerRadius: 25.0 - (progress * 25))
                        .fill(.background)
                        .padding(.top, -progress * heightEapandedBar)
                        .padding(.bottom, -progress * 65)
                        .padding(.horizontal, -progress * 15)
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
                                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
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
            .offset(y: minY < 0 || isSearching ? -minY : 0) // 'isSearching' condition making the navigation bar alwaya appear at the top while search bar is active
            .offset(y: -progress * 65)
        })
        .frame(height: heightEapandedBar)
        .padding(.bottom, 10)
        .padding(.bottom, isSearching ? -65 : 0)
    }

    // Dummy Messages View
    @ViewBuilder
    func DummyMessagesView() -> some View {
        ForEach(1..<20, id: \.self) { count in
            NavigationLink(destination: DetailMessage()) {
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
    
}

//#Preview {
//    Home()
//}
