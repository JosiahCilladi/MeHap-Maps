//
//  SettingsView.swift
//  MeHap Maps
//
//  Created by Josiah Cilladi on 10/22/22.
//

import SwiftUI


struct settingsFile: View {
    
    @State private var text = ""
    @State private var showScannerSheet = false
    
    
    var body: some View {
        SettingsView
    }
    
    struct settingsFile_Previews: PreviewProvider{
        static var previews: some View {
            settingsFile()
            
        }
        
    }
    
    
    var SettingsView: some View {
        
        Text("Settings")
    }
}




