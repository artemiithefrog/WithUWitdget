//
//  ViewModel.swift
//  WithUWitdget
//
//  Created by artemiithefrog . on 02.04.2024.
//

import SwiftUI

class ViewModel: ObservableObject {

  @AppStorage("leftCat", store: UserDefaults(suiteName: "group.artemiithefrog.WithUWitdget"))
  var leftCat = "cat1"
  @AppStorage("rightCat", store: UserDefaults(suiteName: "group.artemiithefrog.WithUWitdget"))
  var rightCat = "cat1"

  var cats: [Cats] = [Cats(name: "cat1"),Cats(name: "cat2"),Cats(name: "cat3"),Cats(name: "cat4"),Cats(name: "cat5")]
}
