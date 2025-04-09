//
//  ContentView.swift
//  PixelPal
//
//  Created by Satvik  Jadhav on 4/7/25.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @StateObject private var drawingViewModel = DrawingViewModel()
    @State private var showingExportSheet = false
    @State private var exportedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Drawing canvas
                    CanvasView(canvasView: $drawingViewModel.canvasView,
                               drawing: $drawingViewModel.drawing,
                               toolPicker: $drawingViewModel.toolPicker,
                               activeLayer: drawingViewModel.activeLayerIndex)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    // Bottom toolbar
                    ToolbarView(viewModel: drawingViewModel)
                }
            }
            .navigationTitle("Pixel Pal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        exportImage()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        drawingViewModel.clearActiveLayer()
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .sheet(isPresented: $showingExportSheet) {
                if let exportedImage = exportedImage {
                    ExportView(image: exportedImage)
                }
            }
        }
    }
    
    func exportImage() {
        exportedImage = drawingViewModel.canvasView.drawing.image(from: drawingViewModel.canvasView.bounds, scale: UIScreen.main.scale)
        showingExportSheet = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
