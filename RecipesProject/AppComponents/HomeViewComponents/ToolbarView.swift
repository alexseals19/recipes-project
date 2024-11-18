//
//  ToolbarView.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/16/24.
//

import SwiftUI

struct ToolbarView: View {
    
    //MARK: - API
    
    @Binding var searchText: String
    @Binding var cuisineOption: String?
        
    init(
        cuisineTypes: [String],
        searchText: Binding<String>,
        cuisineOption: Binding<String?>,
        filterRecipes: @escaping () -> Void
    ) {
        self.cuisineTypes = cuisineTypes
        _searchText = searchText
        _cuisineOption = cuisineOption
        self.filterRecipes = filterRecipes
    }
    
    //MARK: - Properties
    
    
    @FocusState private var isSearchBarFocused: Bool
    
    private let cuisineTypes: [String]
    
    private let filterRecipes: () -> Void
    
    private var cuisineOptionDisplay: String {
        if let cuisineOption {
            return cuisineOption
        }
        return "All"
    }
    
    private var searchBarPadding: CGFloat {
        isSearchBarFocused ? 10 : 0
    }
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            if isSearchBarFocused {
                Color.gray.opacity(0.001)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        isSearchBarFocused = false
                    }
            }
            Spacer()
            HStack(alignment: .center) {
                searchBarView
                    .padding(.bottom, searchBarPadding)
                if !isSearchBarFocused {
                    Divider()
                        .frame(height: 30)
                    Menu {
                        ForEach(cuisineTypes, id: \.self) { cuisine in
                            
                            Button {
                                cuisineOption = cuisine
                            } label: {
                                HStack {
                                    Text(cuisine)
                                        .font(.body)
                                    if cuisineOption == cuisine {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        Button {
                            cuisineOption = nil
                        } label: {
                            HStack {
                                Text("All")
                                    .font(.body)
                                if cuisineOption == nil {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 15)
                                }
                                Spacer()
                            }
                        }
                        
                    } label: {
                        HStack {
                            Text(cuisineOptionDisplay)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.up.chevron.down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                        }
                    }
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                }
                
                
            }
            .foregroundStyle(.primary)
        }
    }
    
    private var searchBarView: some View {
        TextField("Search recipes...", text: $searchText)
            .focused($isSearchBarFocused)
            .frame(maxWidth: .infinity)
            .frame(height: 35)
            .autocorrectionDisabled(true)
            .padding(.horizontal, 15)
            .background(.thinMaterial)
            .tint(.primary)
            .cornerRadius(15)
            .overlay {
                HStack {
                    Spacer()
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                            filterRecipes()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.red.opacity(0.7))
                        }
                        .padding(.trailing, 15)
                    }
                }
            }
            .submitLabel(.search)
            .onSubmit {
                filterRecipes()
            }
    }
}

#Preview {
    ToolbarView(
        cuisineTypes: [],
        searchText: .constant(""),
        cuisineOption: .constant(nil),
        filterRecipes: {}
    )
}
