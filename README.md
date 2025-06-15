# Rick and Morty SwiftUI App

A simple SwiftUI mobile application that fetches data from the public Rick and Morty API and displays it across three intuitive views.

---

## 📱 Features

- Fetch a list of characters from the API
- Display character details (image, status, gender, origin, location)
- Show a list of episodes a character appeared in
- Display episode details (name, air date, episode code, number of characters)
- Loading and error state handling
- Reset view to initial state

---

## 🧰 Tech Stack

- ✅ SwiftUI
- ✅ Async/Await
- ✅ MVC Architecture (Model-View-Controller)
- ✅ ObservableObject + @Published
- ✅ NavigationLink, AsyncImage, ProgressView
- ✅ Minimum Deployment Target: iOS 15.0+

---

## 🧩 Project Structure

```
rick-and-morty/
├── Models/
│   ├── Character.swift
│   ├── Episode.swift
│   └── CharactersResponse.swift
│
├── Views/
│   ├── CharactersListView.swift
│   ├── CharacterDetailsView.swift
│   ├── EpisodeDetailsView.swift
│   └── LaunchScreen.storyboard
│
├── Controllers/
│   ├── APIClient.swift
│   └── CharactersListViewModel.swift
│
├── rick_and_mortyApp.swift
```

---

## 🔍 View Overview

### CharactersListView
- Initial screen with instruction and "Load Characters" button
- Displays character list with image, name and species
- Always visible: "Reset view" button

### CharacterDetailsView
- Displays detailed info about a character
- Includes image, status, gender, origin, location
- Lists episodes with navigation to details

### EpisodeDetailsView
- Displays episode name, air date, episode code, and number of characters

---

## 🛠️ Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Qcineq/rick-and-morty.git
   ```

2. Open the project in Xcode:
   ```bash
   open rick-and-morty.xcodeproj
   ```

3. Run on a simulator or real device (iOS 15.0 or higher).

---

## 🔗 API

This app uses the public Rick and Morty REST API:
- [https://rickandmortyapi.com](https://rickandmortyapi.com)
