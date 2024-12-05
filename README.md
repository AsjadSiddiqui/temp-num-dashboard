# Admin Dashboard Project

This project consists of a frontend built with **Flutter** and a backend built by **Node.js** and **Express**.

## Frontend (Flutter)

### Prerequisites

Before running the Flutter app, ensure that you have the following:

- **Flutter SDK**: Install Flutter from the [official Flutter website](https://flutter.dev/docs/get-started/install).
- **A Web Browser**: The app is designed to run on the web, so make sure you have a compatible browser.

### Running the Frontend

1. Clone this repository or download the project files.
2. Navigate to the project folder and install the required dependencies by running:
   ```bash
   flutter pub get
   ```
3. Run the app using the following command:
   ```bash
   flutter run -d chrome
   ```
   This command will run the app in Chrome.

## Backend (Node.js)

The backend of the project is built using **Node.js** and **Express**. It provides RESTful APIs for managing phone numbers and message counts.

### Prerequisites

Before running the backend server, ensure that you have the following:

- **Node.js**: Install Node.js from the [official Node.js website](https://nodejs.org/).
- **npm**: npm is distributed with Node.js, so you should have it installed.

### Running the Backend

1. Navigate to the `backend` folder in the project.
2. Install the required dependencies by running:
   ```bash
   npm install
   ```
3. Start the backend server using the following command:
   ```bash
    npm run dev
   ```
   The server will start running on `http://localhost:3000`.

## Environment Variables

The project includes example .env files that are required for configuring the backend. These files are committed in the repository, but you need to rename them to .env or create your own environment variables.

### Backend Environment Variables

The backend requires the following environment variables:

- **PORT**: The port on which the server will run.
- **AUTH_TOKEN**: The authentication token for accessing the API.

### Frontend Environment Variables

The frontend requires the following environment variables:

- **API_TOKEN**: The authentication token for accessing the backend API.
