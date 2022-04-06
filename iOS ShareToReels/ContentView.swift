//  Copyright (c) Meta Platforms, Inc. and affiliates.
//  All rights reserved.

//  This source code is licensed under the license found in the
//  LICENSE file in the root directory of this source tree.

//
//  ContentView.swift
//  iOS ShareToReels
//
//  Created by Natalie Takahashi on 10/03/22.
//

import AVKit
import SwiftUI
import UIKit

struct ContentView: View {
    @State private var videoURL: String?
    @State private var showingPicker = false
    @State private var player : AVPlayer?

    // Facebook
    func onShareToFBImageAsStickerClick() {
        let stickerImage = UIImage(named: "Image")?.pngData();
        let appID = "YOUR_APP_ID";
        guard let url = URL(string: videoURL!) else { return }
        let videoData = try? Data.init(contentsOf: url) as Data
        if let urlSchema = URL(string: "facebook-reels://share"){
            if UIApplication.shared.canOpenURL(urlSchema) {
                let pasteboardItems = [
                    ["com.facebook.sharedSticker.backgroundVideo": videoData as Any],
                    ["com.facebook.sharedSticker.stickerImage": stickerImage as Any],
                    ["com.facebook.sharedSticker.appID" : appID]
                ];
                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)];
                 
                UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
                UIApplication.shared.open(urlSchema)
            }
        }
    }

    func onShareToFBImageAsBackgroundClick() {
        let appID = "YOUR_APP_ID";
        guard let url = URL(string: videoURL!) else { return }
        let videoData = try? Data.init(contentsOf: url) as Data
        if let urlSchema = URL(string: "facebook-reels://share"){
            if UIApplication.shared.canOpenURL(urlSchema) {
                let pasteboardItems = [
                    ["com.facebook.sharedSticker.backgroundVideo": videoData as Any],
                    ["com.facebook.sharedSticker.appID" : appID]
                ];

                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)];

                UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
                UIApplication.shared.open(urlSchema)
            }
        }
    }

    var body: some View {
        VStack {
            Text("Share to Reels")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding([.top, .leading], 20.0)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Now you can share a video from your app directly to Facebook Reels")
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding([.leading], 20.0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)

            // Player
            VStack {
                VideoPlayer(player: player)
                .onAppear() {
                }
                .onDisappear() {
                    // Stop the player when the view disappears
                    player?.pause()
                }
                .disabled(videoURL == nil)
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.width)
            }
            .frame(height: UIScreen.main.bounds.width)
            .padding(.all, 20.0)

            // Button Container
            VStack{
                Button ("Upload Video") {
                    showingPicker = true
                }
                .padding(15.0)
                .frame(maxWidth: .infinity, maxHeight: 40.0)
                .background(Color(red: 0.9058823529411765, green: 0.9529411764705882, blue: 1.0))
                .cornerRadius(10)


                Button (action: onShareToFBImageAsBackgroundClick) {
                    Text("Share to Reels")
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding()
                }
                .disabled(videoURL == nil)
                .frame(maxWidth: .infinity, maxHeight: 40.0)
                .background(videoURL == nil ? Color(red: 0.10588235294117647, green: 0.4549019607843137, blue: 0.8941176470588236, opacity: 0.5) : Color(red: 0.10588235294117647, green: 0.4549019607843137, blue: 0.8941176470588236))
                .opacity(videoURL == nil ? 0.7 : 1)
                .cornerRadius(10)
                
                
                Button (action: onShareToFBImageAsStickerClick) {
                    Text("Share to Reels with Sticker")
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding()
                }
                .disabled(videoURL == nil)
                .frame(maxWidth: .infinity, maxHeight: 40.0)
                .background(videoURL == nil ? Color(red: 0.10588235294117647, green: 0.4549019607843137, blue: 0.8941176470588236, opacity: 0.5) : Color(red: 0.10588235294117647, green: 0.4549019607843137, blue: 0.8941176470588236))
                .opacity(videoURL == nil ? 0.7 : 1)
                .cornerRadius(10)
            }
            .padding(.horizontal, 20.0)



            // Footer
            VStack{
                VStack{
                    Text("Sharing to Facebook Reels")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Upload a video and choose one of the options to share it on Facebook Reels!")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.all, 15.0)
                .background(Color(red: 0.9686274509803922, green: 0.9725490196078431, blue: 0.9803921568627451))
                .cornerRadius(10)
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 10.0)


        }
        .sheet(isPresented: $showingPicker) {
            Picker(videoURL: $videoURL)
        }
        .onChange(of: videoURL) { _ in loadVideo() }
        .padding(.top, 10.0)
    }

    func loadVideo()
    {
        guard let urlString = videoURL, let url = URL(string: urlString) else {
            player = nil
            return
        }

        player = AVPlayer(url: url)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
