# Products Task EvenCir App

This project follows Clean Architecture principles and implements the MVC (Model-View-Controller) pattern in Flutter.

## Project Structure

```
lib/
├── core/
│   └── constants/
│       └── app_constants.dart
├── data/
│   ├── models/
│   │   └── base_model.dart
│   └── repositories/
│       └── base_repository.dart
└── presentation/
    ├── controllers/
    │   └── base_controller.dart
    ├── views/
    └── widgets/
```

## Architecture Layers

### 1. Presentation Layer (MVC)
- **Models**: Data classes specific to the UI
- **Views**: Flutter widgets and screens
- **Controllers**: Business logic for the UI, extends BaseController

### 2. Domain Layer
- **Models**: Core business entities
- **Repositories**: Abstract interfaces defining data operations

### 3. Data Layer
- **Models**: Data transfer objects (DTOs)
- **Repositories**: Concrete implementations of domain repositories
- **Services**: API and local storage implementations

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

## Dependencies

- http: For API calls
- provider: For state management
- shared_preferences: For local storage
- get_it: For dependency injection
- injectable: For dependency injection code generation
- freezed: For immutable models
- json_serializable: For JSON serialization

## Best Practices

1. Always extend base classes when creating new components
2. Keep controllers thin and move business logic to services
3. Use dependency injection for better testability
4. Follow SOLID principles
5. Write unit tests for business logic
6. Use proper error handling and loading states
