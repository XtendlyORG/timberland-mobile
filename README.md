# Timberland Mountain Bike Trail Mobile

## About The Project

 - Laboris velit culpa excepteur deserunt in deserunt reprehenderit duis.

### Built With

- [Flutter ](https://flutter.dev/)

<!-- GETTING STARTED -->

## Getting Started

## Project folder structure
- This project follows feature first folder structure.

- 📁 `lib`- Contains the source codes for the project.
    - 📁 `\core`-  Contains shared files
        - 📁 `\themes` - Contains codes for theming the app
        - 📁 `\routes` - Contains the codes for the navigation of the app
        - 📁 `\errors` - Custom exceptions, failure objects, etc
        - 📁 `\utils` - Contains utility classes/functions
        - 📁 `\widgets` - Contains reusable and shared widgets
    - 📁 `\features`- Contains different 
    features of the app.
        Example, authentication feature looks like this:
        - 📁`\authentication` - Contains codes specific for authentication feature of the app
            - 📁`\data` - Data Layer
                - 📁 `\datasources` - Backend connections
                - 📁 `\models` - Data models
                - 📁 `\repositories` - Repository Implementations
            - 📁`\domain` - Domain Layer 
                - 📁 `\entities` - Data Objects
                - 📁 `\repositories` - Abstract repositories
                - 📁 `\usecases` - Usecases of this features
            - 📁`\presentation` - Presentation Layer
                - 📁 `\bloc` - State management we use for this app [flutter_bloc](https://pub.dev/packages/)
                - 📁 `\pages` - pages for authentication feature
                - 📁 `\widgets` - widgets used in authentication feature 
