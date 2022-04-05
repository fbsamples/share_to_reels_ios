//  Copyright (c) Meta Platforms, Inc. and affiliates.
//  All rights reserved.

//  This source code is licensed under the license found in the
//  LICENSE file in the root directory of this source tree.

//
//  Picker.swift
//  iOS ShareToReels
//
//  Created by Carlos Eduardo on 15/03/22.
//

import PhotosUI
import SwiftUI

struct Picker: UIViewControllerRepresentable {
    @Binding var videoURL: String?

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: Picker

        init(_ parent: Picker) {
            self.parent = parent
            self.parent.videoURL = nil
            FileManager.default.clearTmpDirectory()
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }
            provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                if error != nil { return }

                // receiving the video-local-URL / filepath
                guard let url = url else { return }
                // create a new filename
                let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                // create new URL
                let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
                // copy item to APP Storage
                try? FileManager.default.copyItem(at: url, to: newUrl)
                self.parent.videoURL = newUrl.absoluteString
            }
        }
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .videos

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension FileManager {
    func clearTmpDirectory() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        } catch {

        }
    }
}
