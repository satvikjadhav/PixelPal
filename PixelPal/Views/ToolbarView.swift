//
//  ToolbarView.swift
//  PixelPal
//
//  Created by Satvik  Jadhav on 4/7/25.
//

import SwiftUI

struct ToolbarView: View {
    @ObservedObject var viewModel: DrawingViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            // Layer button
            Button {
                viewModel.isShowingLayers.toggle()
            } label: {
                VStack {
                    Image(systemName: "square.on.square")
                        .font(.system(size: 22))
                    Text("Layers")
                        .font(.caption)
                }
            }
            .sheet(isPresented: $viewModel.isShowingLayers) {
                LayersView(viewModel: viewModel)
                    .presentationDetents([.medium])
            }
            
            Spacer()
            
            // Add Layer button
            Button {
                viewModel.addLayer()
            } label: {
                VStack {
                    Image(systemName: "plus.square")
                        .font(.system(size: 22))
                    Text("Add Layer")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
