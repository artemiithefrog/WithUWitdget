//
//  ContentView.swift
//  WithUWitdget
//
//  Created by artemiithefrog . on 02.04.2024.
//

import SwiftUI

struct Cats: Identifiable {
  var id = UUID()
  var name: String
}

struct ContentView: View {

  var cats: [Cats] = [Cats(name: "cat1"),Cats(name: "cat2"),Cats(name: "cat3"),Cats(name: "cat4"),Cats(name: "cat5")]
  @State var leftCat = "cat1"
  @State var rightCat = "cat1"

  var body: some View {
    VStack {
      HStack {
        Text("Left cat")
          .bold()
        Image(leftCat)
          .resizable()
          .frame(width: 75, height: 75)
      }
      HStack {
        Text("Right cat")
          .bold()
        Image(rightCat)
          .resizable()
          .frame(width: 75, height: 75)
      }
      ScrollView {
        HStack {
          ForEach(cats) { cat in
            Image(cat.name)
              .resizable()
              .frame(width: 75, height: 75)
              .onTapGesture {
                leftCat = cat.name
              }
          }
        }
      }
      ScrollView {
        HStack {
          ForEach(cats) { cat in
            Image(cat.name)
              .resizable()
              .frame(width: 75, height: 75)
              .onTapGesture {
                rightCat = cat.name
              }
          }
        }
      }

    }
  }
}

#Preview {
  ContentView()
}
