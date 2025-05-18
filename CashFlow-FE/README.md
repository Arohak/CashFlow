# CashFlow

## Project Description

CashFlow is a personal finance tracking application designed with a clear separation between the client (frontend), server (backend), and shared code. The project aims to provide a robust and modular platform for managing financial transactions, products, and categories.

## Features

Based on the analysis, the project currently includes functionality for:

*   Managing Transactions (Income/Expense)
*   Managing Categories
*   Managing Products
*   API endpoints for interacting with the above data.

Additional features might be present or planned based on the modular structure observed in the frontend (e.g., Home, Profile, Settings, Authentication).

## Architecture

The project follows a Client-Server architecture with a strong emphasis on modularity and code sharing:

*   **Client (`CashFlow-FE`):** A frontend application, likely for iOS or macOS, built using SwiftUI. It adopts a **Vertical Modularity** approach, organizing features into independent, self-contained modules (Feature Modules) which include their own UI, business logic, and data layers.
*   **Server (`CashFlow-BE`):** A backend application built using Swift, likely with the Vapor web framework. It follows a standard web application structure with distinct components for Models, Controllers, and Migrations. The backend is containerized using Docker.
*   **Shared (`Shared`):** A Swift Package that contains code shared between the client and server, primarily Data Transfer Objects (DTOs) for consistent data modeling and communication. This promotes code reuse and reduces boilerplate.

The project is designed to allow developers to run the client and server side-by-side in a single environment, facilitated by tools like Xcode for server development and testing.

## Technologies Used

**Backend (`CashFlow-BE`):**

*   Swift
*   Vapor (inferred)
*   Fluent (ORM)
*   PostgreSQL (Database)
*   Docker / Docker Compose

**Shared (`Shared`):**

*   Swift
*   Swift Package Manager

**Frontend (`CashFlow-FE`):**

*   Swift
*   SwiftUI
*   Xcode
*   Swift Package Manager
*   Modular Design

## Setup and Installation

To set up the project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd CashFlow
    ```
2.  **Set up the Backend Database (using Docker):**
    The backend uses PostgreSQL. You can use the provided `docker-compose.yml` file to spin up a database container.
    ```bash
    docker-compose up -d db
    ```
3.  **Configure Backend Environment Variables:**
    The backend requires environment variables for database connection. You'll need to set these based on your Docker setup or external database. Common variables include:
    *   `DATABASE_URL` (or `DATABASE_HOST`, `DATABASE_PORT`, `DATABASE_USERNAME`, `DATABASE_PASSWORD`, `DATABASE_NAME`)
    *   Consult the `CashFlow-BE/Sources/App/configure.swift` file for the expected environment variables. You might need to create a `.env` file or set these variables in your environment or Xcode scheme.
4.  **Open the Project in Xcode:**
    Open the `CashFlow.xcworkspace` file in Xcode. This workspace should include both the backend and frontend projects, as well as the Shared Swift package.
5.  **Resolve Swift Packages:**
    Xcode should automatically resolve the Swift packages (`Shared` and dependencies for BE/FE). If not, go to `File > Packages > Resolve Package Versions`.

## Running the Application

1.  **Start the Backend:**
    *   In Xcode, select the `CashFlow-BE` scheme.
    *   Choose "My Mac" as the destination.
    *   Run the scheme (`Cmd + R`). The server should start, and you should see logs in the Xcode console. Ensure your database is running (step 2 in Setup).
2.  **Start the Frontend:**
    *   In Xcode, select the `CashFlow-FE` scheme.
    *   Choose a simulator or a connected device as the destination.
    *   Run the scheme (`Cmd + R`). The frontend application should launch.

## Project Structure

*   `CashFlow-FE/`: Contains the frontend (client) application code.
*   `CashFlow-BE/`: Contains the backend (server) application code.
*   `Shared/`: Contains the shared Swift package with DTOs and other common code.
*   `.git/`: Git version control files.
*   `CashFlow.xcworkspace/`: Xcode workspace file encompassing both projects and the shared package.
*   `.gitignore`: Specifies intentionally untracked files that Git should ignore.
*   `Procfile`: For deploying the backend to platforms like Heroku (inferred).
*   `docker-compose.yml`: Defines multi-container Docker application.
*   `Dockerfile`: Defines the Docker image for the backend.
*   `Package.resolved`: Records the exact versions of Swift package dependencies.

## License

This project is licensed under the **[Your Desired License Name]**. See the [LICENSE](LICENSE) file for details.

*(Replace "[Your Desired License Name]" with the actual name of the license you want to use, e.g., MIT License, Apache License 2.0, etc. You should also create a LICENSE file in the root of your repository containing the full text of the license.)*