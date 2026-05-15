# 🎬 MovieDB

A SwiftUI iOS app for browsing and renting movies using [The Movie Database (TMDB) API](https://www.themoviedb.org/documentation/api).

## ✨ Features

- 🎥 Browse **Now Playing** and **Popular** movies
- 🖼️ Movie cards with poster images and metadata
- 📄 Paginated API responses
- 🏷️ Movie genres support
- 💳 Rent movies via **Pix**, **PayPal**, or **Credit Card** (Stripe)
- 📊 Analytics event tracking (screen views and button taps)

## 🏛️ Architecture

The app follows the **MV (Model-View)** pattern — a SwiftUI-native approach where `@Observable` models hold state and business logic, and views observe them directly without a separate ViewModel layer.

- **Models** — `@Observable` stores that own state and drive the UI (`NowPlayingMoviesStore`, `PopularMoviesStore`, `PaymentStore`)
- **Views** — SwiftUI views that observe models and render state
- **Network** — Protocol-based service layer with type-safe endpoint routing and DTO mapping
- **Payment** — Pluggable payment providers via `PaymentProtocol` (Stripe, PayPal, Pix)
- **Analytics** — Pluggable analytics providers via `AnalyticsProtocol`; supports multiple simultaneous providers

### 🔑 Key patterns

- MV pattern with `@Observable` (iOS 17+)
- Protocol-based services for testability and mocking
- Endpoint-based URL building with `URLRequestBuilder`
- Generic `ViewState<Value>` for async loading states
- Typed `NavigationStack` routing via `MovieDetailRoute` / `NowPlayingRoute`
- Pluggable payment providers registered per `PaymentMethod`
- Structured logging with composable decorators (`TimestampLoggable`, `SeverityLoggable`, `FilterLoggable`)
- URLCache configured with 300 MB memory / 1 GB disk

## 📁 Project Structure

```
MovieDB/
├── Analytics/          # Analytics manager, events, and providers
│   ├── Events/
│   └── Providers/
├── Components/         # Reusable UI components (MovieCard, BaseSection)
├── Domain/
│   ├── Mocks/          # Mock data for previews and tests
│   └── Models/         # Domain models (Movie, Genre, Currency)
├── Helpers/
│   └── Logger/         # Structured logging (OSLoggable, decorators)
├── Network/            # Network client, endpoints, DTOs, services
│   └── Mocks/          # MockMoviesService
├── Payment/            # Payment manager, protocol, and providers
│   └── Providers/      # Stripe, PayPal, Pix, Mock
├── Routes/             # Typed navigation routes
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
