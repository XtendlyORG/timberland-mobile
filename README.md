# Timberland Mountain Bike Trail Mobile

## About The Project

 - Timerland Bike Park Booking App

<!-- GETTING STARTED -->
## Getting Started

### Installation
Follow flutter's official docs [here](https://docs.flutter.dev/get-started/install).


###### Clone the repository
```bash
git clone https://github.com/XtendlyORG/timberland-mobile.git
```

###### cd to the project folder
```bash
cd timberland-mobile
```

###### Setup the .env files for dev, staging and prod.
- check the .env.example inside the root folder for the structure of .env files

###### Run the app in different environments (dev, staging, prod)
 - run in dev
 ```bash
flutter run -t lib/main.dart
 ```
- run in staging
 ```bash
flutter run -t lib/main_staging.dart
 ```
 - run in prod
 ```bash
flutter run -t lib/main_prod.dart
 ```


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
