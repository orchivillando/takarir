//
//  SettingsView.swift
//  Takarir
//
//  Created by Grizenzio Orchivillando on 05/05/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("pythonPath") private var pythonPath: String = "/Users/grizenzio/.pyenv/versions/3.10.13/bin/python"
    @AppStorage("scriptPath") private var scriptPath: String = "/Users/grizenzio/Downloads/createsub/create/create_subtitles.py"

    var body: some View {
        Form {
            Section(header: Text("Python Path")) {
                TextField("Python Executable Path", text: $pythonPath)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Section(header: Text("Script Path")) {
                TextField("Subtitle Script Path", text: $scriptPath)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding()
    }
}
