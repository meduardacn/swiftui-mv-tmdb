# 🎬 MovieDB

A SwiftUI iOS app for browsing movies using [The Movie Database (TMDB) API](https://www.themoviedb.org/documentation/api).

## ✨ Features

- 🎥 Browse **Now Playing** and **Popular** movies
- 🖼️ Movie cards with poster images and metadata
- 📄 Paginated API responses
- 🏷️ Movie genres support
- 📊 Analytics event tracking (screen views and button taps)

## 🏛️ Architecture

The app follows the **MV (Model-View)** pattern — a SwiftUI-native approach where `@Observable` models hold state and business logic, and views observe them directly without a separate ViewModel layer.

- **Models** — `@Observable` stores that own state and drive the UI (`NowPlayingMoviesStore`, `PopularMoviesStore`)
- **Views** — SwiftUI views that observe models and render state
- **Network** — Protocol-based service layer with type-safe endpoint routing and DTO mapping
- **Analytics** — Pluggable analytics providers via `AnalyticsProtocol`

### 🔑 Key patterns

- MV pattern with `@Observable` (iOS 17+)
- Protocol-based services for testability and mocking
- Endpoint-based URL building with `URLRequestBuilder`
- Generic `ViewState<Value>` for async loading states
- URLCache configured with 300 MB memory / 1 GB disk

## 📁 Project Structure

```
MovieDB/
├── Analytics/          # Analytics manager, events, and providers
├── Components/         # Reusable UI components (MovieCard)
├── Helpers/            # Utilities (date formatter, logging, view state)
├── Models/             # Domain models (Movie, Genre)
├── Mocks/              # Mock data and services for previews/tests
├── Network/            # Network client, endpoints, DTOs, services
├── Store/              # Observable state stores (MV models)
└── Views/              # SwiftUI views
```

## ⚙️ Requirements

- iOS 17+
- Xcode 15+
- [TMDB API key](https://developer.themoviedb.org/docs/getting-started)

## 🚀 Setup

1. Clone the repository.
2. Get a free API key from [TMDB](https://developer.themoviedb.org/docs/getting-started).
3. Create `MovieDB/MovieDB/Helpers/Secrets.plist` and add a `TMDbAPIKey` entry with your API key.
4. Open `MovieDB/MovieDB.xcodeproj` in Xcode.
5. Build and run on a simulator or device.

> ⚠️ `Secrets.plist` is gitignored and must be created locally — never commit your API key.

## 📦 Dependencies

No external packages — built entirely with SwiftUI and Foundation.
