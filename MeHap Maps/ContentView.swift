//
//  ContentView.swift
//  MeHap Maps
//
//  Created by Josiah Cilladi on 10/8/22.
//

//import CoreLocationUI
import MapKit
import SwiftUI




struct PressableButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .imageScale(.large)
            .background(Color.black)
            .font(.headline)
            .foregroundColor(.gray)
//            .frame(height: 60)
//            .frame(width: 60)
            //.frame(maxWidth: .infinity)
            
            .cornerRadius(7)
            .shadow(color: Color.gray.opacity(0.2),radius: 6, x: 2.0, y:4)
        
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .brightness(configuration.isPressed ? 0.08 : 0)
            //.opacity(configuration.isPressed ? 0.7 : 1.0)
        
    }
    
}


struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()
    
    @State private var isShowingWaypointTypes = false
    @State private var showDetails = false
    @State private var testText = "Texts"
    
    struct Location: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    
     var locations = [
        Location(name: "Location One", coordinate: CLLocationCoordinate2D(latitude: 41.10474, longitude: -72.08910)),
        Location(name: "Location Two", coordinate: CLLocationCoordinate2D(latitude: 41.10117, longitude: -72.09921))
    ]
    
    
    // Test
    var body: some View {
        NavigationView{
            
            ZStack(alignment: .bottomLeading) {
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locations){ location in
                    
                    // TODO move Locations and Location anotations to diffrent files
                    MapAnnotation(coordinate: location.coordinate){
                        NavigationLink {
                            Text(location.name)
                        } label:{
                            HStack {
                                Circle()
                                    .stroke(.blue, lineWidth: 5)
                                    .frame(width: 20, height: 20)
                                    .onTapGesture{
                                        print("Tapped on \(location.name)")
                                    }
                                Text(location.name)
                            }
                            
                        }
                            
                        
                    }
                    
                }
                    .ignoresSafeArea()
                    .accentColor(Color(.black))
                    .onAppear {
                        viewModel.checkIfLocationServicesIsEnabled()
                    }
                
                
                
                HStack(alignment: .center) {
                    
                    VStack(alignment: .center) {
                        Spacer()
                        
                        ZStack(alignment: .center) {
                            Spacer()
                            
                            
                        }
                        
                    }
                    
                    
                    //Spacer()
                    
                    VStack(alignment: .center, spacing: 10) {
                        
                        NavigationLink(destination: settingsFile()){
                            
                            Image(systemName: "ellipsis")
                                .imageScale(.large)
                                .frame(height: 45)
                                .frame(width: 45)
                        }
                        
                            // Ellipsis Waypoint Button
                            //                        Button (action: {
                            //                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            //                            impactMed.impactOccurred()
                            //
                            //                        }, label: {
                            //                            Image(systemName: "ellipsis")
                            //                                .imageScale(.large)
                            //                                .frame(height: 45)
                            //                                .frame(width: 45)
                            //                        })
                            
                            Spacer()
                            
                            
                            NavigationLink(destination: LiveTextFile()){
                                
                                Image(systemName: "text.viewfinder")
                                    .imageScale(.large)
                                    .frame(height: 45)
                                    .frame(width: 45)
                                
                            }
                            
                            
                            // Location Button
                            Button(action: {
                                // vibrates when Button is pressed
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                                
                                print("Location Btn Clicked")
                                viewModel.checkIfLocationServicesIsEnabled()
                            }, label: {
                                //Text("One")
                                Image(systemName: "location")
                                    .imageScale(.large)
                                    .frame(height: 45)
                                    .frame(width: 45)
                                
                            })
                            //.buttonStyle(PressableButtonStyle())
                            //.padding(11)
                            
                       
                            
                            // Add Waypoint Button
                            Button (action: {
                                // vibrates when Button is pressed
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                                
                                isShowingWaypointTypes.toggle()
                                print("Add Waypoint Btn Clicked")
                            }, label: {
                                //Text("One")
                                Image(systemName: "plus")
                                    .imageScale(.large)
                                    .frame(height: 60)
                                    .frame(width: 45)
                            })
                            
                            //.buttonStyle(PressableButtonStyle())
                            //.padding(11)
                            
                            .sheet(isPresented: $isShowingWaypointTypes){
                                NavigationView {
                                    waypointsTypeView()
                                }
                                    .presentationDetents([.fraction(0.25),.fraction((1))])
                                
                            }
                            
                        }
                        //.padding(11)
                        //.buttonStyle(PressableButtonStyle())
                        
                        
                        
                    }
                    .padding(11)
                    .buttonStyle(PressableButtonStyle())
                    
                    
                }
                .padding(0)
            }
            
        }
    
   
        
        
        
        struct ContentView_Previews: PreviewProvider{
            static var previews: some View {
                ContentView()
                
            }
            
        }
    
    
    // TODO Move WaypointsTypeView to new File
    struct waypointsTypeView: View {
        
        @State private var isShowingWaypointTypes = false
        
        var body: some View {
//
                VStack(spacing: 10) {

                    VStack(alignment: .center){



                        Spacer(minLength: 15)


                        HStack(spacing: 10) {





                            Button(action: {
                                // vibrates when Button is pressed

                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()

                                    isShowingWaypointTypes.toggle()

                                    print("Note Btn Clicked")

                            }, label: {
                                //Text("One")
                                NavigationLink(destination: noteFile()){
                                    Image(systemName: "note.text")
                                        .imageScale(.large)
                                        .frame(height: 60)
                                        .frame(width: 60)
                                }
                                         
                            })
                            .buttonStyle(PressableButtonStyle())


                            Button(action: {
                                // vibrates when Button is pressed
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                                isShowingWaypointTypes.toggle()
                                print("Camera Btn Clicked")
                            }, label: {
                                //Text("One")
                                NavigationLink(destination: photoFile()){
                                    Image(systemName: "camera")
                                        .imageScale(.large)
                                        .frame(height: 60)
                                        .frame(width: 60)
                                }
    
                            })
                            .buttonStyle(PressableButtonStyle())

//                            Button(action: {
//                                // vibrates when Button is pressed
//                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                                impactMed.impactOccurred()
//                                isShowingWaypointTypes.toggle()
//                                print("Speak Text Btn Clicked")
//                            }, label: {
//                                //Text("One")
//                                NavigationLink(destination: LiveTextFile()){
//                                    Image(systemName: "text.viewfinder")
//                                        .imageScale(.large)
//                                        .frame(height: 60)
//                                        .frame(width: 60)
//                                }
//                            })
//                            .buttonStyle(PressableButtonStyle())
                            
                            
                            Button(action: {
                                // vibrates when Button is pressed
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                                isShowingWaypointTypes.toggle()
                                print("Shazam Btn Clicked")
                            }, label: {
                                //Text("One")
                                NavigationLink(destination: shazamFile()){
                                    Image(systemName: "shazam.logo")
                                        .imageScale(.large)
                                        .frame(height: 60)
                                        .frame(width: 60)
                                }
                            })
                            .buttonStyle(PressableButtonStyle())


                        }
                        .buttonStyle(PressableButtonStyle())
                    }

                    
                    Spacer()
                }

            }
        }
    }
    
    
    


