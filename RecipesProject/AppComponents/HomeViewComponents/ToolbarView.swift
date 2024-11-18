//
//  ToolbarView.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/16/24.
//

import SwiftUI

struct ToolbarView: View {
    
    //MARK: - API
        
    init(
        cuisineTypes: [String],
        cuisineOption: String?,
        setCuisineAction: @escaping (String?) -> Void,
        searchRecipesAction: @escaping (String) -> Void
    ) {
        self.cuisineTypes = cuisineTypes
        self.cuisineOption = cuisineOption
        self.setCuisineAction = setCuisineAction
        self.searchRecipesAction = searchRecipesAction
    }
    
    //MARK: - Properties
    @State private var searchText: String = ""
    
    @FocusState private var isSearchBarFocused: Bool
    
    private let cuisineTypes: [String]
    private let cuisineOption: String?
    
    private let searchRecipesAction: (String) -> Void
    private let setCuisineAction: (String?) -> Void
    
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
                            Button(cuisine) {
                                setCuisineAction(cuisine)
                            }
                        }
                        Button("All") {
                            setCuisineAction(nil)
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
                            searchRecipesAction(searchText)
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
                searchRecipesAction(searchText)
            }
    }
}

#Preview {
    ToolbarView(
        cuisineTypes: [],
        cuisineOption: nil,
        setCuisineAction: { _ in },
        searchRecipesAction: { _ in }
    )
}
