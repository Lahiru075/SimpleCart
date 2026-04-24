# 🛒 Premium E-Commerce Shopping App (Full Stack)

A professional, minimalist, and luxury e-commerce application built with **Flutter** for the frontend and **Node.js/MongoDB** for the backend. This project focuses on providing a seamless shopping experience with a high-end aesthetic and real-time data integration.

---

## 🌟 Features

### 📱 Frontend (Flutter)
- **Premium Minimalist UI:** A clean, high-fidelity design with rounded corners, subtle shadows, and a luxury color palette.
- **Dynamic Home Screen:** Grid-based product layout with category filtering and a modern search bar.
- **Detailed Product View:** High-quality images, detailed descriptions, and interactive wishlist toggles.
- **Wishlist Management:** Users can save their favorite products and remove them in real-time.
- **User Profile:** A clean profile section with account settings and a professional layout.
- **Custom Bottom Navigation:** A sleek, rounded custom navigation bar for effortless switching between screens.

### ⚙️ Backend (Node.js & MongoDB)
- **RESTful API:** A robust API built with Express.js to handle all product and wishlist operations.
- **MongoDB Atlas:** Cloud database for scalable and secure data storage.
- **Image Hosting:** Integrated with **Cloudinary** for high-performance image uploads and management.
- **CRUD Operations:** Full Create, Read, Update, and Delete functionality for products.
- **Wishlist Logic:** Dynamic wishlist management using MongoDB references (`populate`) for efficient data retrieval.

---

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Frontend** | Flutter, Dart |
| **Backend** | Node.js, Express.js, TypeScript |
| **Database** | MongoDB |
| **Cloud Storage** | Cloudinary |
| **API Testing** | Postman |
| **Version Control** | Git, GitHub |

---

## 📁 Project Architecture

### Frontend Structure
```text
lib/
├── models/      # Data models (Product)
├── screens/     # UI Screens (Home, Details, Wishlist, Profile)
├── services/    # API Service for backend connectivity
├── widgets/     # Reusable UI components (Custom Bottom Nav)
└── main.dart    # Entry point of the application
```

---

## Backend Structure

``` text
src/
├── config/      # Database and Cloudinary configurations
├── controller/  # Business logic for API endpoints
├── middleware/  # Multer for file upload handling
├── model/       # Mongoose schemas (Product, Wishlist)
├── routes/      # API route definitions
└── index.ts     # Server entry point

```

---

## 🚀 API Endpoints

### 📦 Product API

| Method | Endpoint                | Description                          |
|--------|------------------------|--------------------------------------|
| GET    | /api/products          | Fetch all products                   |
| GET    | /api/products/:id      | Fetch single product details         |
| POST   | /api/products          | Create a new product (with image)    |
| PUT    | /api/products/:id      | Update product details               |
| DELETE | /api/products/:id      | Remove a product                     |

---

### ❤️ Wishlist API

| Method | Endpoint               | Description                   |
|--------|------------------------|-------------------------------|
| GET    | /api/wishlist          | Fetch user's wishlist         |
| POST   | /api/wishlist          | Add item to wishlist          |
| DELETE | /api/wishlist/:id      | Remove item from wishlist     |

---

## ⚙️ Installation & Setup

### 🔧 Backend Setup

1. Clone the repository
2. Navigate to the backend folder:
  ```bash
  cd simple_cart_app_be
  ```
3. Install dependencies:
  ```bash
  npm install
  ```
4. Environment Configuration:
  Create a .env file in the root of the backend folder and add the following variables:
  ```bash
  MONGO_URI=your_mongodb_uri
  SERVER_PORT=5000
  CLOUDINARY_NAME=your_name
  CLOUDINARY_API_KEY=your_key
  CLOUDINARY_API_SECRET=your_secret
  ```
5. Start the server:
  ```bash
  npm start
  # OR
  npm run dev
  ```

### 📱 Frontend Setup

1. Navigate to the frontend folder:
  ```bash
  cd simple_cart_app_fe
  ```

2. Install dependencies:
  ```bash
  flutter pub get
  ```

3. Configure API URL:
Update the `baseUrl` in `lib/services/api_service.dart` with your local IP address (e.g., `http://192.168.x.x:5000/api`).

4. Run the application:
  ```bash
  flutter run
  ```

---

## 👨‍💻 Author

Developed by `Lahiru Lakshan`
Passionate Flutter & Node.js Developer
