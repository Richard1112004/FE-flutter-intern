# Richard Shop - Flutter E-commerce App

<div align="center">
  <img src="assets/login/icon.jpg" alt="Richard Shop Logo" width="150">
  <h3>Buy Now, Pay Easy!!</h3>
  <p>A modern Flutter e-commerce application with installment payment options</p>
</div>

## 📱 About

Richard Shop is a comprehensive e-commerce mobile application built with Flutter. The app provides a seamless shopping experience with features like user authentication, product browsing, cart management, order processing, and flexible installment payment plans.

## ✨ Features

### 🔐 Authentication

- **Email/Password Login & Registration**
- **Google Sign-In Integration**
- **Forgot Password Functionality**
- **Secure Session Management**

### 🛍️ Shopping Experience

- **Product Catalog** with detailed product information
- **Image Carousel** for product showcase
- **Product Search & Filtering**
- **Add to Cart** functionality
- **Shopping Cart Management**

### 💳 Payment & Orders

- **Multiple Payment Options**
- **Installment Plans** (6, 9, 12 months with 0% interest)
- **Order History & Tracking**
- **Order Details with Status Updates**

### 👤 User Profile

- **Profile Management**
- **Shipping Address Management**
- **Order History**
- **User Preferences**

### 🔔 Additional Features

- **Push Notifications**
- **Offline Data Caching**
- **Responsive UI Design**
- **State Management with Provider**

## 🏗️ Architecture

The app follows a clean architecture pattern with proper separation of concerns:

```
lib/
├── api/                    # API services and endpoints
├── cart/                   # Shopping cart related screens
├── model/                  # Data models
├── notification/           # Push notification services
├── order/                  # Order management screens
├── products/               # Product related screens
├── profile/                # User profile screens
├── provider/               # State management (Provider pattern)
├── screen/                 # Main application screens
└── main.dart              # Application entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase account (for authentication)
- Google Console project (for Google Sign-In)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Richard1112004/FE-flutter-intern.git
   cd begining
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   - Create a new Firebase project
   - Add your Android/iOS app to the project
   - Download and place `google-services.json` in `android/app/`
   - Enable Authentication (Email/Password and Google)

4. **Environment Configuration**

   - Create `lib/config.env` file
   - Add necessary environment variables

5. **Run the application**
   ```bash
   flutter run
   ```

## 📦 Dependencies

### Core Dependencies

- **flutter**: SDK framework
- **provider**: State management
- **firebase_auth**: Authentication
- **firebase_core**: Firebase initialization
- **google_sign_in**: Google authentication

### UI & UX

- **carousel_slider**: Image carousel
- **shimmer**: Loading animations
- **smooth_page_indicator**: Page indicators
- **cupertino_icons**: iOS style icons

### Utilities

- **http**: HTTP requests
- **shared_preferences**: Local storage
- **path_provider**: File system paths
- **select_dialog**: Dialog selections

### Development

- **flutter_test**: Testing framework
- **flutter_launcher_icons**: App icon generation
- **rename_app**: App renaming utility

## 🎨 UI/UX Design

The app features a modern, clean design with:

- **Blue Theme** (#004BFE primary color)
- **Custom Fonts**: Nunito Sans, Raleway, Roboto
- **Responsive Design** for various screen sizes
- **Intuitive Navigation** with bottom navigation bar
- **Smooth Animations** and transitions

## 📱 Screenshots

The app includes various product categories:

- Electronics (iPhones, Laptops)
- Automotive (Cars)
- And more...

## 🔧 Key Features Implementation

### Installment Payment System

The app offers flexible payment plans:

- **6 months**: 0% interest + $5 processing fee
- **9 months**: 0% interest + $10 processing fee
- **12 months**: 0% interest + $15 processing fee

### State Management

Uses Provider pattern for:

- User authentication state
- Shopping cart state
- Navigation state
- Form validation state
- UI state management

### API Integration

- RESTful API communication
- Error handling and validation
- Offline data caching
- Real-time data synchronization

## 🔒 Security Features

- Secure authentication with Firebase
- Input validation and sanitization
- Secure local storage
- Protected API endpoints
- Session management

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web (partial support)
- ✅ Windows (partial support)
- ✅ macOS (partial support)
- ✅ Linux (partial support)

## 🚀 Build & Deployment

### Android

```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Richard1112004**

- GitHub: [@Richard1112004](https://github.com/Richard1112004)

## 📞 Support

For support and questions:

- Create an issue on GitHub
- Contact the development team

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors and testers

---

<div align="center">
  <p>Made with ❤️ using Flutter</p>
  <p>© 2024 Richard Shop. All rights reserved.</p>
</div>
