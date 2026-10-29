# Maven E-Commerce Store Data Analysis 📊

## 🚀 Project Overview
This project performs an end-to-end data analytics study on a multi-table relational e-commerce database (Maven Fuzzy Factory). It tracks the full customer lifecycle—from initial website traffic sessions and pageviews to completed orders, line-item purchases, and product refunds.

---

## 🗄️ Database Architecture & Schema
The project utilizes 6 interconnected relational tables extracted and queried using MS SQL Server:
* **`website_sessions`** – Web traffic data, marketing acquisition sources, and session details.
* **`pageviews`** – User navigation tracking and page-level hit records.
* **`orders`** – Transactional summaries including order totals and primary product IDs.
* **`order_items`** – Line-item breakdowns per order.
* **`order_item_refunds`** – Customer returns and refund item details.
* **`products`** – Catalog mapping of product lines and release dates.

---

## 📈 Power BI Dashboard Highlights
* **Total Products Sold:** 24K
* **Total Revenue:** $1.94M
* **Total Orders:** 32K

### Dashboard Previews
![Dashboard View 1](maven-ecommerce%20dashboard%201....png)

![Dashboard View 2](Maven-ecommerce-dashboard2....png)

---

## 🛠️ Tech Stack
* **Database Management & Querying:** Microsoft SQL Server (SSMS)
* **Data Visualization & Analytics:** Power BI Desktop
* **Source Dataset:** Maven Analytics
