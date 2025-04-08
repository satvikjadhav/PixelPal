//
//  DrawingViewModel.swift
//  PixelPal
//
//  Created by Satvik  Jadhav on 4/7/25.
//

import SwiftUI
import PencilKit

class DrawingViewModel: ObservableObject {
    @Published var canvasView = PKCanvasView()
    @Published var drawing = PKDrawing()
    @Published var toolPicker = PKToolPicker()
    @Published var layers: [PKDrawing] = [PKDrawing()]
    @Published var activeLayerIndex = 0
    @Published var selectedColor: Color = .black
    @Published var isShowingLayers = false
    
    init() {
        // Initial setup
        canvasView.backgroundColor = .clear
    }
    
    // Layer management
    func addLayer() {
        layers.append(PKDrawing())
        activeLayerIndex = layers.count - 1
        updateCanvasDrawing()
    }
    
    func deleteLayer(at index: Int) {
        guard layers.count > 1, index < layers.count else { return }
        
        layers.remove(at: index)
        if activeLayerIndex >= layers.count {
            activeLayerIndex = layers.count - 1
        }
        updateCanvasDrawing()
    }
    
    func clearActiveLayer() {
        layers[activeLayerIndex] = PKDrawing()
        updateCanvasDrawing()
    }
    
    func selectLayer(at index: Int) {
        guard index < layers.count else { return }
        activeLayerIndex = index
        updateCanvasDrawing()
    }
    
    func updateCanvasDrawing() {
        // Update the active layer with the current canvas drawing
        if activeLayerIndex < layers.count {
            layers[activeLayerIndex] = canvasView.drawing
            
            // Combine all layers into a single drawing
            var combinedDrawing = PKDrawing()
            for layer in layers {
                combinedDrawing.append(layer)
            }
            drawing = combinedDrawing
        }
    }
    
    // Tool selection
    func setColor(_ color: Color) {
        selectedColor = color
        // PencilKit handles the tool color through its own UI
    }
}
