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

    private let bgPrimary = Color(red: 0.10588235294117647, green: 0.4549019607843137, blue: 0.8941176470588236)
    private let bgSecondary = Color(red: 0.9058823529411765, green: 0.9529411764705882, blue: 1.0)
    private var bgTertiary = Color(red: 0.8941176470588236, green: 0.9019607843137255, blue: 0.9215686274509803)

    private let appID = "YOUR_APP_ID"

    // Facebook Share to Reels
    func onShareToFBReelsClick(includeSticker: Bool = false) {
        guard let url = URL(string: videoURL!) else { return }
        let videoData = try? Data.init(contentsOf: url) as Data
        if let urlSchema = URL(string: "facebook-reels://share"){
            if UIApplication.shared.canOpenURL(urlSchema) {
                var pasteboardItems = [
                    ["com.facebook.sharedSticker.backgroundVideo": videoData as Any],
                    ["com.facebook.sharedSticker.appID" : appID]
                ];

                if (includeSticker) {
                    let stickerImage = UIImage(named: "Image")?.pngData();
                    pasteboardItems.append(["com.facebook.sharedSticker.stickerImage": stickerImage as Any]);
                }

                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)];

                UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
                UIApplication.shared.open(urlSchema)
            }
        }
    }

    // Instagram Share to Reels
    func onShareToIGReelsClick(includeSticker: Bool = false) {
        guard let url = URL(string: videoURL!) else { return }
        let videoData = try? Data.init(contentsOf: url) as Data
        if let urlSchema = URL(string: "instagram-reels://share"){
            if UIApplication.shared.canOpenURL(urlSchema) {
                var pasteboardItems = [
                    ["com.instagram.sharedSticker.backgroundVideo": videoData as Any],
                    ["com.instagram.sharedSticker.appID" : appID]
                ];

                if (includeSticker) {
                    let stickerImage = UIImage(named: "Image")?.pngData();
                    pasteboardItems.append(["com.instagram.sharedSticker.stickerImage": stickerImage as Any]);
                }

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

            Text("Now you can share a video from your app directly to Facebook or Instagram Reels!")
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
                .background(bgSecondary)
                .cornerRadius(10)

                VStack {
                    Text("Facebook Reels")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Button (action: {onShareToFBReelsClick(includeSticker: false)}) {
                            Text("Share to Reels")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                        .disabled(videoURL == nil)
                        .frame(maxWidth: .infinity, maxHeight: 40.0)
                        .background(bgPrimary)
                        .opacity(videoURL == nil ? 0.7 : 1)
                        .cornerRadius(10)

                        Button (action: {onShareToFBReelsClick(includeSticker: true)}) {
                            Text("Share with Sticker")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.primary)
                                .padding()
                                .opacity(videoURL == nil ? 0.7 : 1)
                        }
                        .disabled(videoURL == nil)
                        .frame(maxWidth: .infinity, maxHeight: 40.0)
                        .background(bgTertiary)
                        .opacity(videoURL == nil ? 0.7 : 1)
                        .cornerRadius(10)
                    }
                }

                Divider()

                VStack {
                    Text("Instagram Reels")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Button (action: {onShareToIGReelsClick(includeSticker: false)}) {
                            Text("Share to Reels")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                        .disabled(videoURL == nil)
                        .frame(maxWidth: .infinity, maxHeight: 40.0)
                        .background(bgPrimary)
                        .opacity(videoURL == nil ? 0.7 : 1)
                        .cornerRadius(10)

                        Button (action: {onShareToIGReelsClick(includeSticker: true)}) {
                            Text("Share with Sticker")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.primary)
                                .padding()
                                .opacity(videoURL == nil ? 0.7 : 1)
                        }
                        .disabled(videoURL == nil)
                        .frame(maxWidth: .infinity, maxHeight: 40.0)
                        .background(bgTertiary)
                        .opacity(videoURL == nil ? 0.7 : 1)
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, 20.0)
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
