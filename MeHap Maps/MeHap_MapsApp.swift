//
//  MeHap_MapsApp.swift
//  MeHap Maps
//
//  Created by Josiah Cilladi on 10/8/22.
//

import SwiftUI

@main
struct MeHap_MapsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
