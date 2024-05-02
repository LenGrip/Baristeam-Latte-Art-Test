//
//  MainView.swift
//  latte-art
//
//  Created by Reza Athallah Rasendriya on 29/04/24.
//
import CoreMotion
import CoreHaptics
import SwiftUI

struct MainView: View {
    @Environment(\.dismiss) private var dismiss
    let motion = CMMotionManager()
    
    @State var progressTimer: Timer?
    @State var progressBarWidth = 50.0
    @State var remainingTime: Double = 15.0
    
    @State var gyroTimer: Timer?
    @State var isPour = false
    
    var body: some View {
        ZStack {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color(.appProggressBarBackground))
                            .frame(width: 350, height: 70)
                        Capsule()
                            .fill(.appProggressBar)
                            .frame(width: progressBarWidth, height: 50)
                            .padding(.leading, 10)
                    }
                }
                .padding(.top, 70)
                
                Spacer()

                VStack {
                    ZStack {
                        Image("main-area")
                        
                        HStack {
                            Spacer()
                            
//                            Button(action: {
//                                dismiss()
//                            }) {
//                                CircleButton(icon: "arrowshape.backward.fill", size: "small")
//                            }
//                            .padding(.trailing, 30)
                            
                            Spacer()
                            
                            Button(action: {
                                startPour()
                            }, label: {
                                CircleButton(icon: "mug.fill", size: "large")
                            })
                            
                            Spacer()
                            
//                            Button(action: {}) {
//                                CircleButton(icon: "arrow.circlepath", size: "small")
//                            }
//                            .padding(.leading, 30)
                            
                            Spacer()
                        }

                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
//        .background(Color.brown)
        .ignoresSafeArea()
    }
    
    func updateBar() {
        progressBarWidth += 2.8
    }
    
    func takeSnapshot() {
        
    }
    
//    func addMilk() {
//        ARViewContainer.addMilk()
//    }
    
    func startTimer() {
//        playHapticFeedback()
        progressTimer?.invalidate()
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
            if (remainingTime > 0) {
                decrementTimer()
                
                if (remainingTime == 23) {
//                    playHapticFeedback()
                }
            } else {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    func startPour() {
        if motion.isGyroAvailable {
            self.motion.gyroUpdateInterval = 0.2
              self.motion.startGyroUpdates()


              // Configure a timer to fetch the accelerometer data.
            self.gyroTimer = Timer(fire: Date(), interval: (0.2),
                     repeats: true, block: { (timer) in
                 // Get the gyro data.
                 if let data = self.motion.gyroData {
                    let x = data.rotationRate.x
                     if(x < 0) {
                         isPour = true
                         startTimer()
                     } else {
                         isPour = false
                         stopTimer()
                     }
                 }
              })

              // Add the timer to the current run loop.
            RunLoop.current.add(self.gyroTimer!, forMode: RunLoop.Mode.default)
           }
    }
    
    func stopPour() {
        if self.gyroTimer != nil {
              self.gyroTimer?.invalidate()
              self.gyroTimer = nil


              self.motion.stopGyroUpdates()
           }
    }
    
    func decrementTimer() {
        remainingTime -= 0.15
        updateBar()
    }
}

#Preview {
    MainView()
}
