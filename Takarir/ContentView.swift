import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var videoThumbnail: Image?
    @State private var scriptOutput = ""
    @State private var isProcessing = false
    @State private var videoURL: URL?
    @State private var selectedLanguageCode = "english"
    @State private var progress: Double = 0.0
    @State private var videoDuration: String = ""
    @AppStorage("pythonPath") var pythonPath: String = "/usr/bin/python3"
    @AppStorage("scriptPath") var scriptPath: String = "/Users/grizenzio/create_subtitles.py"

    let allLanguages: [Language] = [
        Language(name: "English", code: "english"),
        Language(name: "Indonesian", code: "indonesian"),
        Language(name: "Russian", code: "russian"),
        Language(name: "Arabic", code: "arabic"),
        Language(name: "Chinese", code: "chinese"),
        Language(name: "French", code: "french"),
        Language(name: "German", code: "german"),
        Language(name: "Hindi", code: "hindi"),
        Language(name: "Japanese", code: "japanese"),
        Language(name: "Korean", code: "korean"),
        Language(name: "Spanish", code: "spanish"),
        Language(name: "Portuguese", code: "portuguese"),
        Language(name: "Bengali", code: "bengali"),
        Language(name: "Urdu", code: "urdu"),
        Language(name: "Swahili", code: "swahili"),
        Language(name: "Tamil", code: "tamil"),
        Language(name: "Turkish", code: "turkish"),
        Language(name: "Vietnamese", code: "vietnamese"),
        Language(name: "Polish", code: "polish"),
        Language(name: "Ukrainian", code: "ukrainian"),
        Language(name: "Dutch", code: "dutch"),
        Language(name: "Greek", code: "greek"),
        Language(name: "Czech", code: "czech"),
        Language(name: "Romanian", code: "romanian"),
        Language(name: "Hungarian", code: "hungarian"),
        Language(name: "Hebrew", code: "hebrew"),
        Language(name: "Thai", code: "thai"),
        Language(name: "Swedish", code: "swedish"),
        Language(name: "Finnish", code: "finnish"),
        Language(name: "Norwegian", code: "norwegian"),
        Language(name: "Danish", code: "danish"),
        Language(name: "Malay", code: "malay"),
        Language(name: "Filipino", code: "filipino"),
        Language(name: "Persian", code: "persian"),
        Language(name: "Hindi", code: "hindi"),
        Language(name: "Tamil", code: "tamil"),
        Language(name: "Bengali", code: "bengali")
    ]

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                if let thumbnail = videoThumbnail {
                    thumbnail
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Text("")
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                        .overlay(
                            VStack {
                                Image(systemName: "arrow.down.circle.fill") // SF Symbol icon
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 8) // Menambahkan jarak di bawah ikon

                                Text("Add or Drag video file here")
                                    .font(.headline)
                            }
                            .padding()
                        )
                        .onTapGesture {
                            // Open Finder dialog when clicked
                            openFilePicker()
                        }
                }
            }
            .onDrop(of: ["public.file-url"], isTargeted: nil) { providers in
                if let provider = providers.first {
                    provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { item, _ in
                        if let data = item as? Data,
                           let url = URL(dataRepresentation: data, relativeTo: nil) {
                            DispatchQueue.main.async {
                                self.videoURL = url
                                self.scriptOutput = ""         // Reset output
                                self.progress = 0.0            // Reset progress
                                self.generateThumbnail(from: url)
                                print("File dropped: \(url.path)")
                            }
                        }
                    }
                    return true
                }
                return false
            }
            
            if videoURL == nil {
                Button("Select Video File") {
                    openFilePicker()
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            

            if let url = videoURL {
                VStack(alignment: .leading) {
                    Text("File: \(url.lastPathComponent)")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Duration: \(videoDuration)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
            }

            Picker("Language", selection: $selectedLanguageCode) {
                ForEach(allLanguages) { lang in
                    Text(lang.name).tag(lang.code)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)

            HStack(spacing: 16) {
                Button("Create Subtitles") {
                    runPythonScript(with: videoURL)
                }
                .disabled(videoURL == nil || isProcessing)
                .buttonStyle(.borderedProminent)
                .tint(.blue)

                Button("Change Video") {
                    self.videoURL = nil
                    self.scriptOutput = ""
                    self.progress = 0.0
                    self.isProcessing = false
                    self.videoThumbnail = nil
                }
                .disabled(videoURL == nil || isProcessing)
                .buttonStyle(.borderedProminent)
                .tint(.gray)
            }

            if isProcessing {
                ProgressView("Processing...")
                    .padding()
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding(.horizontal)
                Text(String(format: "%.0f%%", progress * 100))
                    .font(.caption)
                    .foregroundColor(.gray)
            } else if scriptOutput == "success" {
                VStack(spacing: 8) {
                    Label("Subtitle Successfully Created", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()

                    Button("Open Folder") {
                        if let videoURL = videoURL {
                            let folderURL = videoURL.deletingLastPathComponent()
                            NSWorkspace.shared.open(folderURL)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else if !scriptOutput.isEmpty {
                ScrollView {
                    Text(scriptOutput)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
            }
            
            
            Text("Takarir v1.0 by Grizenzio Orchivillando")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, -30)
            
            Text("Takarir is a simple tool to create subtitles from video files.")
                .font(.footnote)
                .foregroundColor(.gray)
                
            Spacer()
                .frame(maxHeight: .infinity)
            
        }
        .padding()
    }
    
    func getVideoDuration(from url: URL) {
        let asset = AVAsset(url: url)
        
        Task {
            do {
                let duration = try await asset.load(.duration)
                let durationSeconds = CMTimeGetSeconds(duration)
                
                let minutes = Int(durationSeconds) / 60
                let seconds = Int(durationSeconds) % 60
                DispatchQueue.main.async {
                    self.videoDuration = String(format: "%02d:%02d", minutes, seconds)
                }
            } catch {
                print("❌ Failed to load duration: \(error)")
            }
        }
    }
    
    // Fungsi untuk menghasilkan thumbnail dari video
    func generateThumbnail(from url: URL) {
        let asset = AVAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true

        let time = CMTime(seconds: 1.0, preferredTimescale: 600)
        do {
            let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
            let nsImage = NSImage(cgImage: cgImage, size: .zero)
            let swiftUIImage = Image(nsImage: nsImage)
            DispatchQueue.main.async {
                self.videoThumbnail = swiftUIImage
                self.getVideoDuration(from: url)
            }
        } catch {
            print("❌ Failed to generate thumbnail: \(error)")
        }
    }
    
    // Fungsi untuk membuka dialog pemilihan file
    func openFilePicker() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [
            .movie,  // Ini akan memungkinkan untuk memilih file video
            .audio   // Kamu bisa menambahkan tipe lain jika diperlukan
        ]
        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK, let url = panel.url {
            // Jika pengguna memilih file, lakukan sesuatu dengan file tersebut
            DispatchQueue.main.async {
                self.videoURL = url
                self.generateThumbnail(from: url)
                self.scriptOutput = ""  // Reset output
                self.progress = 0.0     // Reset progress
                print("File selected: \(url.path)")
            }
        }
    }
    
    // Fungsi untuk mengekstrak progress dari output
    func extractProgress(from output: String) {
        let pattern = #"Transcribe:\s*(\d+)%\|"#
        if let match = output.range(of: pattern, options: .regularExpression) {
            let matchedText = String(output[match])
            let percentString = matchedText.replacingOccurrences(of: "Transcribe:", with: "")
                .components(separatedBy: "%").first?.trimmingCharacters(in: .whitespaces) ?? ""
            if let percent = Double(percentString) {
                self.progress = percent / 100.0
            }
        }
    }

    func runPythonScript(with videoURL: URL?) {
        guard let videoPath = videoURL?.path else { return }

        isProcessing = true
        scriptOutput = ""
        progress = 0.0

        let process = Process()
        process.executableURL = URL(fileURLWithPath: pythonPath)

        let env = process.environment ?? [:]
        process.environment = env.merging(["PATH": "/opt/homebrew/bin:\(env["PATH"] ?? "")"]) { (_, new) in new }

        process.arguments = [scriptPath, videoPath, "-s", "-v", "-p", "1.0", "-l", selectedLanguageCode]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        pipe.fileHandleForReading.readabilityHandler = { handle in
            let data = handle.availableData
            if !data.isEmpty, let output = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.extractProgress(from: output)
                    print(output) // hanya log ke console, tidak tampil di UI
                }
            }
        }

        do {
            try process.run()

            DispatchQueue.global().asyncAfter(deadline: .now() + 300) {
                if process.isRunning {
                    process.terminate()
                    DispatchQueue.main.async {
                        self.scriptOutput = "⚠️ Process timeout. Terminated."
                        self.isProcessing = false
                    }
                }
            }

            process.terminationHandler = { _ in
                DispatchQueue.main.async {
                    self.isProcessing = false
                    self.progress = 1.0
                    self.scriptOutput = "success"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.scriptOutput = "❌ Error running script: \(error)"
                self.isProcessing = false
            }
        }
    }
    
}

struct Language: Identifiable {
    let id = UUID()
    let name: String
    let code: String
}

#Preview {
    ContentView()
}
