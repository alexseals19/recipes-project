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
    
    init(
        searchText: Binding<String>,
        sortOption: SortOption,
        sortRecipes: @escaping (SortOption) -> Void
    ) {
        _searchText = searchText
        self.sortOption = sortOption
        self.sortRecipes = sortRecipes
    }
    
    //MARK: - Properties
    
    @FocusState private var isSearchBarFocused: Bool
    
    private let sortOption: SortOption
    
    private let sortRecipes: (SortOption) -> Void
    
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
                        Button("Name") {
                            sortRecipes(.name)
                        }
                        Button("Cuisine") {
                            sortRecipes(.cuisine)
                        }
                    } label: {
                        HStack {
                            Text(sortOption.rawValue)
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
    }
}

#Preview {
    ToolbarView(
        searchText: .constant(""),
        sortOption: .name,
        sortRecipes: {_ in}
    )
}
