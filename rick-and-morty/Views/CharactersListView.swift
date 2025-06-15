//
//  ContentView.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 14/06/2025.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject private var viewModel = CharactersListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.hasLoaded {
                    if viewModel.isLoading {
                        ProgressView("Ładowanie...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                            .padding()
                    } else if let error = viewModel.errorMessage {
                        VStack(spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .font(.largeTitle)
                            Text(error)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.characters) { character in
                                    NavigationLink(destination: CharacterDetailsView(character: character)) {
                                        HStack(spacing: 16) {
                                            AsyncImage(url: URL(string: character.image)) { image in
                                                image.resizable()
                                            } placeholder: {
                                                Color.gray.opacity(0.3)
                                            }
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))

                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(character.name)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                Text(character.species)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                        .background(Color(.systemBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        Text("Stuknij przycisk poniżej, aby załadować postacie z uniwersum Ricka i Morty’ego.")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button(action: {
                            Task {
                                await viewModel.loadCharacters()
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.down.circle.fill")
                                    .font(.title2)
                                Text("Załaduj postacie")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .padding()
                            .frame(maxWidth: 300)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                            .scaleEffect(1.02)
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
                
                Button(action: {
                    Task {
                        viewModel.reset()
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.uturn.down.circle.fill")
                            .font(.title2)
                        Text("Zresetuj widok")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .padding()
                    .frame(maxWidth: 300)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .scaleEffect(1.02)
                    .padding(.horizontal)
                }
                .buttonStyle(PlainButtonStyle())

//                Button("Reset View") {
//                    viewModel.reset()
//                }
//                .font(.subheadline)
//                .foregroundColor(.blue)
//                .padding(.top, 10)
            }
            .navigationTitle("Rick & Morty")
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    CharactersListView()
}
