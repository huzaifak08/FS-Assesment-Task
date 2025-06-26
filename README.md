# Simple Firebase-Based Product Listing App (Mini eCommerce)

This is a simple Flutter-based eCommerce app with Firebase authentication and Firestore integration. The app allows users to register and login using Firebase, browse a list of products, view product details, and manage a cart stored locally using Riverpod.

## Table of Contents

- [Features](#features)
- [Firebase Setup](#firebase-setup)
  - [1. Firebase Authentication](#1-firebase-authentication)
  - [2. Firestore Setup](#2-firestore-setup)
  - [3. Firebase Security Rules](#3-firebase-security-rules)
- [App Setup](#app-setup)
- [State Management](#state-management)
- [UI/UX](#uix)
- [Error Handling](#error-handling)
- [Known Issues](#known-issues)
- [How to Run the App](#how-to-run-the-app)
- [Deliverables](#deliverables)

## Features

### Core Features

1. **Authentication**
   - Email/password sign-up & login using Firebase Authentication.
   - Logout functionality.
   - Optional: Form validation and error handling.
2. **Product List Screen**

   - Fetch products from Firebase Firestore.
   - Display product title, image, and price.
   - Use a grid or card layout.
   - Shimmer loading or skeleton view during data fetching.

3. **Product Detail Screen**

   - Show all details of a selected product.
   - Add to cart functionality (local, not saved in Firestore).

4. **Cart Screen**
   - Manage cart items locally using **Riverpod**.
   - Show a list of products, quantities, and total cost.
   - Allow removing items or adjusting quantity.

### Bonus Features (Optional)

- Firebase Firestore Security Rules (show basic user-level access).
- Product search functionality.
- Dark mode toggle.
- Hero animation between product list and details screen.
- Product images hosted via Firebase Storage.

## Firebase Setup

### 1. Firebase Authentication

- Go to the Firebase console and create a new Firebase project.
- In your Firebase project, navigate to **Authentication** and enable **Email/Password** sign-in method.
- Use the following dependencies in your `pubspec.yaml` file:

  ```yaml
  firebase_auth: ^5.6.0
  firebase_core: ^3.14.0
  ```

- **Enable Email/Password Authentication**:

  1.  Go to Firebase Console → Authentication → Sign-in method.
  2.  Enable **Email/Password**.

- Add your **google-services.json** or **GoogleService-Info.plist** to the project for Android/iOS setup.

### 2. Firestore Setup

- Create a Firestore collection named `products`.
- Each document in the `products` collection should have the following fields:
  - `name` (String)
  - `price` (Number)
  - `image_url` (String)
  - `description` (String)
  - `category` (String)

**Firestore dependencies**:

```yaml
cloud_firestore: ^5.6.9
```
