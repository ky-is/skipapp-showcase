// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TabViewPlayground: View {
    @State var selectedTab = "Home"

    var body: some View {
        TabView(selection: $selectedTab) {
            TabPlaygroundContentView(label: "Home", selectedTab: $selectedTab)
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag("Home")
            TabView {
                TabPlaygroundContentView(label: "Favorites (page 1)", selectedTab: $selectedTab)
                    .padding(32)
                    .background {
                        Capsule()
                            .fill(Color.pink.opacity(0.1))
                    }
                Text("More (page 2)")
            }
            .tabViewStyle(.page)
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
            .tag("Favorites")
            TabPageViewContentView()
                .tabItem { Label("Paging", systemImage: "arrow.forward.square") }
                .tag("Paging")
        }
        .tint(.red)
        .toolbar {
            PlaygroundSourceLink(file: "TabViewPlayground.swift")
        }
    }

    struct TabPageViewContentView: View {
        @State var pageCount = 1

        var body: some View {
            ScrollView {
                VStack {
                    TabView {
                        Rectangle()
                            .fill(Color.gray)
                            .overlay {
                                Text("This is a horizontally swipable paging TabView")
                            }
                        Text("2")
                            .background(Color.red)
                        Text("I heard you like TabViews so we put a TabView inside your TabView inside your TabView")
                            .background(Color.green)
                    }
                    .frame(height: 128)
                    TabView {
                        Rectangle()
                            .fill(Color.indigo)
                            .overlay {
                                Text("Unconstrained\nTabView")
                            }
                        Text("2")
                            .background(Color.red)
                    }
                    TabView {
                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: 256, height: 64)
                            .overlay {
                                Text("Fixed size content, flexible container")
                            }
                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: 64, height: 96)
                    }
                    TabView {
                        Image(systemName: "heart")
                            .resizable()
                            .background(Color.pink)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .background(Color.red)
                    }
                    .aspectRatio(2, contentMode: ContentMode.fill)
                    TabView {
                        ForEach(1...pageCount, id: \.self) { pageNumber in
                            Rectangle()
                                .fill(Color(hue: Double(pageNumber) * 0.1, saturation: 0.5, brightness: 1))
                                .overlay {
                                    Button("Add page \(pageCount + 1)") {
                                        pageCount += 1
                                    }
                                    if pageCount > 1 {
                                        Button("Remove page \(pageCount)") {
                                            pageCount -= 1
                                        }
                                    }
                                }
                        }
                    }
                    .frame(height: 128)
                    TabView {
                        Rectangle()
                            .fill(Color.mint)
                            .overlay {
                                Text("Single page with indicator showing")
                            }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 128)
                    TabView {
                        Rectangle()
                            .fill(Color.green)
                            .overlay {
                                Text("Multi page with indicator hidden")
                            }
                        Text("2")
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 128)
                }
                .tabViewStyle(.page)
                .foregroundStyle(Color.white)
            }
        }
    }
}

struct TabPlaygroundContentView: View {
    let label: String
    @Binding var selectedTab: String

    var body: some View {
        VStack {
            Text(label).bold()
            if label != "Home" {
                Button("Switch to Home") {
                    selectedTab = "Home"
                }
            }
            if label != "Favorites" {
                Button("Switch to Favorites") {
                    selectedTab = "Favorites"
                }
            }
            if label != "Paging" {
                Button("Switch to Paging") {
                    selectedTab = "Paging"
                }
            }
        }
    }
}

#Preview {
    TabViewPlayground()
}
