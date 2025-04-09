//
//  LayersView.swift
//  PixelPal
//
//  Created by Satvik  Jadhav on 4/8/25.
//

import SwiftUI

struct LayersView: View {
    @ObservedObject var viewModel: DrawingViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(viewModel.layers.enumerated()), id: \.offset) { index, layer in
                    LayerRowView(
                        index: index,
                        isActive: index == viewModel.activeLayerIndex,
                        onSelect: {
                            viewModel.selectLayer(at: index)
                        }
                    )
                    .swipeActions {
                        if viewModel.layers.count > 1 {
                            Button(role: .destructive) {
                                viewModel.deleteLayer(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Layers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct LayerRowView: View {
    let index: Int
    let isActive: Bool
    let onSelect: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: isActive ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isActive ? .blue : .gray)
            
            Text("Layer \(index + 1)")
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onSelect()
        }
    }
}
