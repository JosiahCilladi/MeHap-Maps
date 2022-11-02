//
//  LiveTextView.swift
//  MeHap Maps
//
//  Created by Josiah Cilladi on 10/22/22.
//

import SwiftUI
import ScanTextField

import AVFoundation

struct LiveTextFile: View {
    
    @State private var text = ""
    @State private var showScannerSheet = false
    
    //@State private var inputMessage = "This is a test. This is only a test. Thank you for listning. Good Day!"
    
    
    var body: some View {
        TextScanView
    }
    struct LiveTextFile_Previews: PreviewProvider{
        static var previews: some View {
            LiveTextFile()
            
        }
        
    }
    
    
    var TextScanView: some View {
        
        VStack() {
            
            
            // TODO Replace ScanTextField with native SwiftUI text to speach intagration
            ScanTextField("Enter name", text: $text)
                .padding(18)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            //.fixedSize(horizontal: true, vertical: true)
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
            
            
            Button(action: {
                print("Speak Text")
                // vibrates when Button is pressed
                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                impactMed.impactOccurred()
                
                
                
                text2speech()
                
                
                
            }, label: {
                //Text("One")
                Image(systemName: "person.wave.2")
                    .imageScale(.large)
                    .frame(height: 45)
                    .frame(width: 45)
                
            })
        }
    }
    
    let synthesizer = AVSpeechSynthesizer()
    
    func text2speech() {
            print(text)
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.52
            utterance.pitchMultiplier = 2
            self.synthesizer.speak(utterance)
        }
    
    
    
    
}




