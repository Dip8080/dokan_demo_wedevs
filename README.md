# Flutter Demo App

This project is a Flutter application that demonstrates user registration, login with JWT authentication, profile updates, and displaying products on the home page. The app is compatible with both Android and iOS.

## Table of Contents

- [Features](#features)
- [Setup](#setup)
- [Endpoints](#endpoints)
- [Screenshots](#screenshots)
- [Git Commit Messages](#git-commit-messages)
- [Contact](#contact)

## Features

1. **User Registration**
   - Users can sign up with a username, email, and password.

2. **User Login**
   - Users can log in with their username and password.

3. **Profile Update**
   - Authenticated users can update their profile information (first name, last name).

4. **Home Page**
   - Displays products from the provided JSON data.
   - Implements filter actions as required.

5. **Native Splash Screen**
   - A native splash screen is implemented for both Android and iOS.

## Setup

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Android Studio or Xcode for iOS

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/Dip8080/dokan_demo_wedevs.git
    ```
2. Navigate to the project directory:
    ```bash
    cd your-repository-name
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Run the app:
    ```bash
    flutter run
    ```

### Building APK

To build the APK for Android:
```bash
flutter build apk --release
