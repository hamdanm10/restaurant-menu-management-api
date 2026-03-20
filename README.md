# Restaurant Menu Management API

A robust **Ruby on Rails API** designed for managing restaurant menu data with a focus on maintainability, consistent data structures, and seamless front-end integration.

---

## 🚀 Tech Stack

* **Framework:** Ruby on Rails 8 (API Only)
* **Database:** PostgreSQL
* **Language:** Ruby
* **Testing:** RSpec
* **Key Libraries:**
    * `Pagy`: For high-performance pagination.
    * `Ransack`: For flexible data searching and filtering.
    * `FactoryBot`: For a robust testing ecosystem.

---

## 🛠 Setup & Installation

Follow these steps to get the project running in your local environment:

1.  **Clone the Repository**
    ```bash
    git clone git@github.com:hamdanm10/restaurant-menu-management-api.git
    cd restaurant-menu-management-api
    ```

2.  **Install Dependencies**
    ```bash
    bundle install
    ```

3.  **Database Configuration**
    Ensure PostgreSQL is running, then execute:
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4.  **Start the Server**
    ```bash
    rails server
    ```
    The API will be accessible at `http://localhost:3000`.

5.  **Run the Test Suite**
    ```bash
    bundle exec rspec
    ```

---

## 🏗 Design Decisions

In developing this API, several architectural choices were made to ensure the application remains scalable and clean:

### 1. Service Object Pattern
All business logic has been moved from the **Controllers** into dedicated **Service Objects**.
* **Rationale:** To keep controllers lean ("Skinny Controllers") and focused only on handling requests and responses.
* **Benefit:** This makes the codebase more modular, easier to maintain, and allows for isolated unit testing of business rules.

### 2. JSend Response Format
The API implements the **JSend** specification for all server responses.
* **Rationale:** JSend provides a predictable JSON structure (`status`, `data`, `message`).
* **Benefit:** It offers enough consistency for front-end requirements without the overhead of more complex specifications like JSON:API, making integration straightforward for developers.

### 3. Testing with RSpec
We chose **RSpec** as the primary testing framework over the default Rails Minitest.
* **Rationale:** RSpec provides a highly descriptive Domain Specific Language (DSL) that describes behavior rather than just code.
* **Benefit:** The test cases serve as clear technical documentation, making the intent of the code easier to understand for the whole team.

### 4. Efficient Data Handling
We integrated **Pagy** and **Ransack** directly into the API layer.
* **Benefit:** This allows clients to perform complex filtering and rapid pagination with minimal server memory usage, ensuring high performance even as the menu data grows.

---

## 📖 API Endpoints (Preview)

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| POST | `/api/v1/restaurants` | Create a restaurant |
| GET | `/api/v1/restaurants` | List all restaurants with filtering & pagination |
| GET | `/api/v1/restaurants/:id` | Get restaurant detail (include menu items) |
| PUT | `/api/v1/restaurants/:id` | Update a restaurant |
| DELETE | `/api/v1/restaurants/:id` | Delete a restaurant |
| POST | `/api/v1/restaurants/:id/menu_items` | Add a menu item |
| GET | `/api/v1/restaurants/:id/menu_items` | List all menu items with filtering & pagination |
| PUT | `/api/v1/menu_items/:id` | Update a menu item |
| DELETE | `/api/v1/menu_items/:id` | Delete a menu item |

---

## 🔍 Usage Examples

### Searching & Filtering (Ransack)
You can filter data using the `q` parameter. Ransack allows for complex queries directly via URL:

* **Search by Name:**
  `GET /api/v1/restaurants?q[name_cont]=Restaurant`
* **Filter by Category Name (Association):**
  `GET /api/v1/restaurants/:id/menu_items?q[category_eq]=main`

### Custom Data Limiting
You can control the amount of data returned per request using the `limit` parameter:

* **Fetch top 10 items:**
  `GET /api/v1/restaurants?limit=10`
* **Combined with Search:**
  `GET /api/v1/restaurants?q[name_cont]=Restaurant&limit=10`