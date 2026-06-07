# Library Management System

## Description

Library Management System is a web-based application developed using Flutter, NestJS, and MySQL. This system helps manage library operations such as book management, member management, and borrowing records.

## Features

* Dashboard with real-time statistics
* Book Management

  * View books
  * Add books
  * Delete books
* Member Management

  * View members
  * Add members
  * Delete members
* Borrowing Management

  * View borrowing records
  * Add borrowing records
  * Delete borrowing records

## Technology Stack

### Frontend

* Flutter

### Backend

* NestJS
* TypeORM

### Database

* MySQL

## System Architecture

The system follows a Layered Architecture pattern:

Presentation Layer (Flutter)
↓
Controller Layer (NestJS Controllers)
↓
Service Layer (Business Logic)
↓
Repository Layer (TypeORM)
↓
Database Layer (MySQL)

## Project Structure

frontend/

* Flutter Application

backend/

* NestJS REST API

database/

* MySQL Database

## Installation

### Backend

```bash
cd backend/backend_api
npm install
npm run start:dev
```

### Frontend

```bash
cd frontend
flutter pub get
flutter run
```

### Database

1. Create a MySQL database named:

```sql
library_system
```

2. Configure database credentials in the NestJS configuration file.

## API Endpoints

### Books

* GET /books
* POST /books
* DELETE /books/:id

### Members

* GET /members
* POST /members
* DELETE /members/:id

### Borrowings

* GET /borrowings
* POST /borrowings
* DELETE /borrowings/:id

### Dashboard

* GET /dashboard/stats

## Authors

Software Architecture Project

Kelvin Nicolas Naga (2802469280)
Azraqi Aldian Wijaya (2802503362)
