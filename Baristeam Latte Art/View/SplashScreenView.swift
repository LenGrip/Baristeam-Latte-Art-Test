//
//  HomeView.swift
//  latte-art
//
//  Created by Reza Athallah Rasendriya on 29/04/24.
//

import AVFoundation
import SwiftUI

struct SplashScreenView: View {
    @State var isAudioPlaying = false
    @State var player: AVAudioPlayer?
    var body: some View {
        NavigationView {
            ZStack {
                Image("splash")
                
                VStack {
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink(destination: MainView(), label: {
                            CircleButton(icon: "play.fill", size: "large")
                        })
                        Spacer()
                    }
                    
                    Button(action: {
                        isAudioPlaying ? stopAudio() : playAudio()
                    }, label: {
                        
                        if isAudioPlaying {
                            CircleButton(icon: "speaker.wave.2.fill", size: "small")
                        } else {
                            CircleButton(icon: "speaker.slash.fill", size: "small")
                        }
                        
                    })
                }
                .padding(.bottom, 100)
                .padding(.top, 100)
                
            }
            .background(Color.appMain)
        }
        .onAppear(perform: {
            setupAudio()
        })
    }
    
    func setupAudio() {
        guard let soundURL = Bundle.main.url(forResource: "bg", withExtension: "mp3") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("failed to play \(error.localizedDescription)")
        }
    }
    
    private func playAudio() {
        player?.play()
        isAudioPlaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        isAudioPlaying = false
    }
}

#Preview {
    SplashScreenView()
}
