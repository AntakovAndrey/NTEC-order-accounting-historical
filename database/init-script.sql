USE master;
GO

-- Создание базы данных
CREATE DATABASE NTEC_order_accounting_db;
GO

USE NTEC_order_accounting_db;
GO

-- Таблица ролей
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL
);


-- Таблица пользователей
CREATE TABLE Users (
    UserId INT PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    RoleId INT,
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);


-- Таблица клиентов
CREATE TABLE Clients (
    ClientId INT PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Patronymic NVARCHAR(100),
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    CompanyInfo NVARCHAR(255)
);


-- Таблица категорий услуг
CREATE TABLE ServiceCategories (
    CategoryId INT PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    CategoryDescription NVARCHAR(255)
);


-- Таблица услуг
CREATE TABLE Services (
    ServiceId INT PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL,
    ServiceDescription NVARCHAR(255),
    CategoryId INT,
    FOREIGN KEY (CategoryId) REFERENCES ServiceCategories(CategoryId)
);

-- Таблица заказов
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    ClientId INT,
    UserId INT,
    CreationDate DATETIME NOT NULL,
    FOREIGN KEY (ClientId) REFERENCES Clients(ClientId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Таблица статуса выполнения услуги
CREATE TABLE ServiceExecutionStatus (
    StatusId INT PRIMARY KEY,
    StatusName NVARCHAR(50) NOT NULL
);

-- Таблица заказ_услуга
CREATE TABLE OrderServices (
    OrderServiceId INT PRIMARY KEY,
    ServiceId INT,
    OrderId INT,
    StatusId INT,
    ExecutorUserId INT,
    Cost DECIMAL(18, 2),
    FOREIGN KEY (ServiceId) REFERENCES Services(ServiceId),
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    FOREIGN KEY (StatusId) REFERENCES ServiceExecutionStatus(StatusId),
    FOREIGN KEY (ExecutorUserId) REFERENCES Users(UserId)
);

-- Таблица дополнительных параметров услуги
CREATE TABLE ServiceAdditionalParameters (
    ParameterId INT PRIMARY KEY,
    ServiceId INT,
    ParameterName NVARCHAR(100) NOT NULL,
    ParameterDescription NVARCHAR(255),
    ParameterCost DECIMAL(18, 2),
    FOREIGN KEY (ServiceId) REFERENCES Services(ServiceId)
);

-- Таблица доп.параметр_заказ_услуга
CREATE TABLE OrderServiceAdditionalParameters (
    OrderServiceParameterId INT PRIMARY KEY,
    ParameterId INT,
    OrderServiceId INT,
    DiscountPercentage DECIMAL(5, 2),
    Quantity INT,
    TotalCost DECIMAL(18, 2),
    FOREIGN KEY (ParameterId) REFERENCES ServiceAdditionalParameters(ParameterId),
    FOREIGN KEY (OrderServiceId) REFERENCES OrderServices(OrderServiceId)
);

INSERT INTO Roles (RoleId, RoleName) VALUES
(1, 'Admin'),
(2, 'User');