//
//  ContentView.swift
//  WithUWitdget
//
//  Created by artemiithefrog . on 02.04.2024.
//

import SwiftUI
import WidgetKit

struct ContentView: View {

  @StateObject var vm = ViewModel()

  var body: some View {
    VStack {
      HStack {
        Text("Left cat")
          .bold()
        Image(vm.leftCat)
          .resizable()
          .frame(width: 75, height: 75)
      }
      HStack {
        Text("Right cat")
          .bold()
        Image(vm.rightCat)
          .resizable()
          .frame(width: 75, height: 75)
      }
      ScrollView {
        HStack {
          ForEach(vm.cats) { cat in
            Image(cat.name)
              .resizable()
              .frame(width: 75, height: 75)
              .onTapGesture {
                vm.leftCat = cat.name
                UserDefaults(suiteName: "group.artemiithefrog.WithUWitdget")?.setValue(cat.name, forKey: "catLeft")
              }
          }
        }
      }
      ScrollView {
        HStack {
          ForEach(vm.cats) { cat in
            Image(cat.name)
              .resizable()
              .frame(width: 75, height: 75)
              .onTapGesture {
                vm.rightCat = cat.name
                UserDefaults(suiteName: "group.artemiithefrog.WithUWitdget")?.setValue(cat.name, forKey: "catRight")
              }
          }
        }
      }
    }
    .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
      WidgetCenter.shared.reloadTimelines(ofKind: "HelloWorldSmallWidget")
      WidgetCenter.shared.reloadTimelines(ofKind: "HelloWorldMediumWidget")
      print("Widget reloaded")
    }
  }
}
#Preview {
  ContentView()
}
