drop database group_project;

create database group_project;

use group_project;


drop table if exists Customers;
create table Customers
( CustomerID			smallint not null auto_increment,
  CustomerType			varchar(25) not null,
  OrderStatus			varchar(25) not null,
  FirstName				varchar(50) not null,
  LastName				varchar(50) not null,
  StreetAddress			varchar(100) not null,
  City					varchar(50) not null,
  State					Char(2) not null,
  ZipCode				varchar(10),
constraint PK_Customers_CustomerID Primary Key ( CustomerID )
);


drop table if exists CustomerEmailAddress;

Create Table CustomerEmailAddress
( CustomerID		smallint not null,
  EmailAddress		varchar(254) not null,
  PrimaryEmailFlag	char(1) not null default 'Y',
  constraint PK_CustomerEmailAddress_CustomerID_EmailAddress primary key ( CustomerID, EmailAddress ),
  constraint FK_CustomerEmailAddress_CustomerID foreign key (CustomerID) references Customers (CustomerID)
);


Drop Table if exists CustomerPhoneNumber;

create table CustomerPhoneNumber
( CustomerID		smallint not null,
  PhoneNumber		varchar(17) not null,
  PrimaryPhoneFlag	char(1) not null default 'Y',
  constraint PK_CustomerPhoneNumber_CustomerID_PhoneNumber primary key ( CustomerID, PhoneNumber ),
  constraint FK_CustomerPhoneNumber_CustomerID foreign key (CustomerID) references Customers (CustomerID)
);


Drop table if exists Drivers;
-- COME BACK TO ONCE SOLVED ON LUCID
Create Table Drivers
( DriverID			Smallint not null auto_increment,
  DriverStatus		varchar(100) not null,
  FirstName			varchar(50) not null,
  LastName			varchar(50) not null,
  PhoneNumber		varchar(17) not null,
  constraint PK_Drivers_DriverID primary key (DriverID)
);


Drop Table if exists Marketing;

Create Table Marketing
( CampaignID		Smallint not null,
  AdCost			decimal(12,2) not null,
  constraint PK_Marketing_CampaignID primary key (CampaignID)
);


drop table if exists Restaurant;

create table Restaurant
( RestaurantID			smallint not null auto_increment,
  StreetAddress			varchar(100) not null,
  City					varchar(50) not null,
  State					Char(2) not null,
  ZipCode				varchar(10) not null,
  PhoneNumber			varchar(17) not null,
  constraint PK_Restaurant_RestaurantID primary key ( RestaurantID)
);


drop table if exists Application;

create table Application
( DNSID			smallint not null,
  CustomerID	smallint not null,
  constraint PK_Application_DNSID primary key (DNSID),
  constraint FK_Application_CustomerID foreign key (CustomerID) references Customers (CustomerID)
);


drop table if exists Orders;

create table Orders
( OrderID			smallint not null auto_increment,
  OrderDateTime		Time not null,
  RestaurantID		smallint not null,
  DNSID				smallint not null,
  CampaignID		smallint not null,
  CustomerID		smallint not null,
  constraint PK_Orders_OrderID primary key(OrderID),
  constraint FK_Orders_RestaurantID foreign key ( RestaurantID) references Restaurant ( RestaurantID),
  constraint FK_Orders_DNSID foreign key ( DNSID ) references Application ( DNSID ),
  constraint FK_Orders_CampaignID foreign key ( CampaignID ) references Marketing ( CampaignID ),
  constraint FK_Orders_CustomerID foreign key ( CustomerID ) references Customers ( CustomerID )
);


drop table if exists MenuItem;

Create Table MenuItem
( MenuItemID			smallint not null,
  ItemName				varchar(50) not null,
  ItemPrice				Decimal(5,2) not null,
  constraint PK_MenuItem_MenuItemID primary key ( MenuItemID)
);


drop table if exists OrderItem;

create table OrderItem
( OrderID				smallint not null auto_increment,
  MenuItemID			smallint not null,
  OrderPrice			Decimal(6,2) not null,
  Quantity				tinyint not null,
  constraint PK_OrderItem_OrderID_MenuItemID primary key ( OrderID, MenuItemID ),
  constraint FK_OrderItem_OrderID foreign key ( OrderID ) references Orders ( OrderID ),
  constraint FK_OrderItem_MenuItemID foreign key (MenuItemID) references MenuItem (MenuItemID)
);


drop table if exists Subscription;

create table Subscription
( CustomerID 			smallint not null,
  SubscriptionID 		smallint not null,
  ChargeDate			date not null,
  BeginTime				time not null,
  EndTime				time default null,
  constraint PK_Subscription_CustomerID_SubscriptionID primary key ( CustomerID, SubscriptionID),
  constraint FK_Subscription_CustomerID foreign key ( CustomerID) references Customers (CustomerID)
);


drop table if exists Review;

create table Review
( ReviewID				smallint not null auto_increment,
  CustomerID			smallint not null,
  DriverID				smallint not null,
  Rating				varchar(5) not null,
  ReviewTime			time not null,
  constraint PK_Review_ReviewID primary key (ReviewID),
  constraint FK_Review_CustomerID foreign key (CustomerID) references Customers ( CustomerID),
  constraint FK_Review_DriverID foreign key (DriverID) references Drivers (DriverID)
);



drop table if exists CustomerService;

create table CustomerService
( CustomerServiceID		smallint not null auto_increment,
  CustomerID			smallint not null,
  OrderID				smallint not null,
  DriverID				smallint not null,
  constraint PK_CustomerService_CustomerServiceID primary key ( CustomerServiceID),
  constraint FK_CustomerService_CustomerID foreign key ( CustomerID) references Customers (CustomerID),
  constraint FK_CustomerService_OrderID foreign key( OrderID) references Orders (OrderID),
  constraint FK_CustomerService_DriverID foreign key (DriverID) references Drivers (DriverID)
);


drop table if exists Payment;

create table Payment
( PaymentID				smallint not null,
  OrderID				smallint not null,
  OverallPrice			decimal(6,2) not null,
  PaymentType			varchar(10) not null,
  constraint PK_Payment_PaymentID primary key (PaymentID),
  constraint FK_Payment_OrderID foreign key (OrderID) references Orders (OrderID)
);


drop table if exists CardPayment;

create table CardPayment
( PaymentID				smallint not null,
  CardID				smallint not null,
  PrimaryCardFlag		varchar(1) not null default 'Y',
  constraint PK_CardPayment_PaymentID_CardID primary key (PaymentID, CardID),
  constraint FK_CardPayment_PaymentID foreign key (PaymentID) references Payment (PaymentID)
);


drop table if exists MobilePayment;

Create table MobilePayment
( PaymentID				smallint not null,
  MobileID				smallint not null,
  PrimaryMobileFlag		varchar(1) not null default 'Y',
  constraint PK_MobilePayment_PaymentID_MobileID primary key (PaymentID, MobileID),
  constraint FK_MobilePayment_PaymentID foreign key (PaymentID) references Payment (PaymentID)
);


INSERT INTO Customers (CustomerType, OrderStatus, FirstName, LastName, StreetAddress, City, State, ZipCode)
VALUES		('Subscriber', 'Active', 'Luke', 'Foster', '823 Aztec Dr', 'Phoenix', 'AZ', '98271'),
			('Non-Subscriber', 'Pending', 'John', 'Doe', '456 Oak Ave', 'Denver', 'CO', '80201'),
			('Subscriber', 'Inactive', 'Emily', 'Johnson', '789 Pine Rd', 'Chicago', 'IL', '60601'),
			('Subscriber', 'Active', 'Daniel', 'Brown', '321 Cedar Blvd', 'Austin', 'TX', '73301'),
			('Non-Subscriber', 'Active', 'Grace', 'Lee', '654 Birch St', 'Miami', 'FL', '33101'),
			('Subscriber', 'Inactive', 'Michael', 'Taylor', '777 Elm Dr', 'Boston', 'MA', '02101'),
			('Subscriber', 'Active', 'Sarah', 'Martinez', '900 Walnut Ln', 'Phoenix', 'AZ', '85001'),
			('Non-Subscriber', 'Banned', 'David', 'Nguyen', '101 Maple Way', 'Portland', 'OR', '97201'),
			('Subscriber', 'Pending', 'Linda', 'Walker', '202 Chestnut Ct', 'Atlanta', 'GA', '30301'),
			('Subscriber', 'Active', 'Robert', 'Lopez', '303 Fir Cir', 'New York', 'NY', '10001'),
			('Subscriber', 'Inactive', 'Karen', 'Scott', '404 Ash St', 'Philadelphia', 'PA', '19101'),
			('Non-Subscriber', 'Active', 'James', 'Allen', '505 Spruce Pl', 'Las Vegas', 'NV', '88901'),
			('Subscriber', 'Pending', 'Jessica', 'Young', '606 Poplar Ave', 'Salt Lake City', 'UT', '84101'),
			('Subscriber', 'Inactive', 'Christopher', 'King', '707 Sequoia St', 'Columbus', 'OH', '43004'),
			('Non-Subscriber', 'Banned', 'Amanda', 'Hill', '808 Dogwood Rd', 'Minneapolis', 'MN', '55401'),
			('Subscriber', 'Active', 'Brian', 'Green', '909 Alder Ln', 'San Francisco', 'CA', '94101'),
			('Subscriber', 'Inactive', 'Rebecca', 'Nelson', '112 Beech Blvd', 'Honolulu', 'HI', '96801'),
			('Subscriber', 'Pending', 'George', 'Carter', '223 Redwood Ct', 'Boise', 'ID', '83701'),
			('Non-Subscriber', 'Active', 'Laura', 'Mitchell', '334 Sycamore Cir', 'New Orleans', 'LA', '70112'),
			('Subscriber', 'Inactive', 'Andrew', 'Perez', '445 Ironwood Dr', 'Nashville', 'TN', '37201'),
			('Subscriber', 'Active', 'Angela', 'Roberts', '556 Hemlock Way', 'Anchorage', 'AK', '99501'),
			('Non-Subscriber', 'Pending', 'Jason', 'Campbell', '667 Larch Ave', 'Detroit', 'MI', '48201'),
			('Subscriber', 'Inactive', 'Rachel', 'Turner', '778 Cedar Pl', 'Omaha', 'NE', '68101'),
			('Subscriber', 'Banned', 'Kevin', 'Phillips', '889 Magnolia Ln', 'Charlotte', 'NC', '28201'),
			('Subscriber', 'Inactive', 'Stephanie', 'Bennett', '991 Palm St', 'Albuquerque', 'NM', '87101'),
			('Subscriber', 'Active', 'Frank', 'Cook', '123 Apple Ave', 'Little Rock', 'AR', '72201'),
			('Non-Subscriber', 'Inactive', 'Ashley', 'Rivera', '234 Banana Blvd', 'Des Moines', 'IA', '50301'),
			('Subscriber', 'Active', 'Brandon', 'Collins', '345 Cherry Rd', 'Indianapolis', 'IN', '46201'),
			('Non-Subscriber', 'Banned', 'Nicole', 'Howard', '456 Date Ct', 'Jackson', 'MS', '39201'),
			('Subscriber', 'Inactive', 'Ethan', 'Ward', '567 Elderberry St', 'Billings', 'MT', '59101'),
			('Subscriber', 'Pending', 'Megan', 'Torres', '678 Fig Cir', 'Manchester', 'NH', '03101'),
			('Non-Subscriber', 'Inactive', 'Dylan', 'Gray', '789 Grape Dr', 'Fargo', 'ND', '58102'),
			('Subscriber', 'Active', 'Olivia', 'Ramirez', '890 Honeydew Ln', 'Providence', 'RI', '02901'),
			('Subscriber', 'Pending', 'Jacob', 'James', '901 Kiwi Pl', 'Columbia', 'SC', '29201'),
			('Subscriber', 'Inactive', 'Chloe', 'Watson', '111 Lemon Blvd', 'Sioux Falls', 'SD', '57101'),
			('Subscriber', 'Inactive', 'Zachary', 'Brooks', '222 Mango Ct', 'Burlington', 'VT', '05401'),
			('Non-Subscriber', 'Active', 'Madison', 'Kelly', '333 Nectarine Way', 'Virginia Beach', 'VA', '23450'),
			('Subscriber', 'Inactive', 'Nathan', 'Reed', '444 Orange Ave', 'Milwaukee', 'WI', '53201'),
			('Subscriber', 'Pending', 'Abigail', 'Bailey', '555 Papaya Rd', 'Cheyenne', 'WY', '82001'),
			('Subscriber', 'Banned', 'Liam', 'Jenkins', '666 Quince Cir', 'Washington', 'DC', '20001');
            
            
SELECT * FROM Customers;

INSERT INTO CustomerEmailAddress (CustomerID, EmailAddress, PrimaryEmailFlag)
VALUES     (1, 'luke.foster$gmail.com', 'Y'),
		   (2, 'john.doe$gmail.com', 'Y'),
		   (3, 'emily.johnson$yahoo.com', 'N'),
		   (4, 'daniel.brown$outlook.com', 'Y'),
		   (5, 'grace.lee$gmail.com', 'Y'),
		   (6, 'michael.taylor$hotmail.com', 'N'),
		   (7, 'sarah.martinez$aol.com', 'Y'),
		   (8, 'david.nguyen$gmail.com', 'Y'),
		   (9, 'linda.walker$protonmail.com', 'N'),
		   (10, 'robert.lopez$icloud.com', 'N'),
		   (11, 'karen.scott$live.com', 'Y'),
		   (12, 'james.allen$yahoo.com', 'N'),
		   (13, 'jessica.young$gmail.com', 'Y'),
		   (14, 'christopher.king$outlook.com', 'Y'),
		   (15, 'amanda.hill$zoho.com', 'N');
       
       
SELECT * FROM CustomerEmailAddress;


INSERT INTO CustomerPhoneNumber (CustomerID, PhoneNumber, PrimaryPhoneFlag)
VALUES	   (1, '480-435-8384', 'Y'),
		   (2, '782-945-8914', 'N'),
		   (3, '987-198-1983', 'Y'),
		   (4, '018-751-2354', 'Y'),
		   (5, '874-532-5325', 'Y'),
		   (6, '987-451-3582', 'N'),
		   (7, '981-554-1234', 'Y'),
		   (8, '234-976-5243', 'N'),
		   (9, '429-837-6244', 'Y'),
		   (10, '230-987-6247', 'Y'),
		   (11, '091-753-1268', 'Y'),
		   (12, '474-622-4529', 'N'),
		   (13, '992-745-6264', 'N'),
		   (14, '764-209-2451', 'Y'),
		   (15, '849-497-6242', 'Y');


SELECT * FROM CustomerPhoneNumber;


INSERT INTO Drivers (DriverStatus, FirstName, LastName, PhoneNumber)
VALUES		('On route', 'Gavin', 'Cahoon','385-497-2475'),
			('Available', 'Liam', 'Anderson', '212-555-1034'),
			('Unavailable', 'Emma', 'Thompson', '303-555-2048'),
			('On route', 'Noah', 'Robinson', '702-555-9981'),
			('Available', 'Olivia', 'Clark', '818-555-7733'),
			('Unavailable', 'William', 'Wright', '615-555-4122'),
			('On route', 'Sophia', 'Hall', '512-555-6677'),
			('Available', 'James', 'Green', '973-555-3090'),
			('Unavailable', 'Isabella', 'Young', '206-555-7878'),
			('On route', 'Benjamin', 'Allen', '904-555-6611'),
			('Available', 'Mia', 'King', '701-555-2288'),
			('Unavailable', 'Lucas', 'Scott', '503-555-4442'),
			('On route', 'Charlotte', 'Evans', '404-555-9191'),
			('Available', 'Laura', 'Bush', '801-555-3333'),
			('Unavailable', 'Drunk', 'Crasher', '919-555-1420');
            
            
SELECT * FROM Drivers;


INSERT INTO Marketing (CampaignID, AdCost)
VALUES 		(1, 1094.94),
			(2, 875.20),
			(3, 1523.50),
			(4, 639.99),
			(5, 2040.75),
			(6, 999.00),
			(7, 1304.60),
			(8, 1845.30),
			(9, 745.25),
			(10, 1599.99),
			(11, 1222.10),
			(12, 960.40),
			(13, 1100.00),
			(14, 1433.33),
			(15, 1788.88);
            
            
SELECT * FROM Marketing;


INSERT INTO Restaurant (RestaurantID, StreetAddress, City, State, ZipCode, PhoneNumber)
VALUES		(1, '532 Oak St', 'Austin', 'TX', '71583', '970-958-5931'),
			(2, '123 Elm St', 'Denver', 'CO', '80203', '303-555-1234'),
			(3, '78 Maple Ave', 'Chicago', 'IL', '60614', '312-888-7766'),
			(4, '456 Pine Rd', 'Phoenix', 'AZ', '85004', '602-234-5678'),
			(5, '910 Birch Ln', 'Portland', 'OR', '97209', '503-222-3333'),
			(6, '102 Cedar Ct', 'Atlanta', 'GA', '30303', '678-999-1212'),
			(7, '321 Walnut Blvd', 'Miami', 'FL', '33101', '305-123-9876'),
			(8, '678 Chestnut St', 'Seattle', 'WA', '98101', '206-555-7890'),
			(9, '890 Spruce Dr', 'Boston', 'MA', '02108', '617-777-2323'),
			(10, '234 Fir Cir', 'Nashville', 'TN', '37201', '615-444-9898'),
			(11, '567 Redwood Pl', 'Las Vegas', 'NV', '89109', '702-321-4567'),
			(12, '135 Beech Way', 'New York', 'NY', '10001', '212-678-1234'),
			(13, '789 Poplar St', 'Philadelphia', 'PA', '19103', '267-123-4567'),
			(14, '345 Ash Ave', 'Minneapolis', 'MN', '55401', '612-999-0000'),
			(15, '432 Magnolia Blvd', 'San Diego', 'CA', '92101', '619-888-4321');
            
            
SELECT * FROM Restaurant;


INSERT INTO Application (DNSID, CustomerID)
VALUES		(1, 5),
			(2, 12),
			(3, 3),
			(4, 8),
			(5, 20),
			(6, 1),
			(7, 14),
			(8, 9),
			(9, 4),
			(10, 11),
			(11, 2),
			(12, 7),
			(13, 6),
			(14, 17),
			(15, 10);
            
            
SELECT * FROM Application;


INSERT INTO Orders (OrderDateTime, RestaurantID, DNSID, CampaignID, CustomerID)
VALUES 		('10:23:11', 1, 5, 2, 4),
			('12:45:32', 2, 7, 3, 10),
			('14:12:56', 3, 9, 4, 2),
			('16:37:22', 4, 11, 5, 6),
			('18:03:44', 5, 13, 6, 8),
			('20:30:18', 1, 15, 7, 1),
			('22:17:50', 2, 15, 8, 3),
			('08:09:33', 3, 1, 1, 5),
			('09:15:27', 4, 3, 2, 7),
			('11:48:09', 5, 6, 3, 9),
			('13:26:45', 1, 8, 4, 11),
			('15:58:29', 2, 10, 5, 12),
			('17:41:03', 3, 12, 6, 13),
			('19:23:40', 4, 14, 7, 14),
			('21:06:12', 5, 13, 8, 15),
			('23:59:59', 1, 14, 1, 16),
			('01:13:00', 2, 2, 2, 17),
			('03:28:36', 3, 4, 3, 18),
			('05:44:19', 4, 1, 4, 19),
			('07:01:50', 5, 2, 5, 20),
			('10:35:22', 1, 2, 6, 21),
			('12:50:05', 2, 2, 7, 22),
			('14:15:44', 3, 3, 8, 23),
			('16:03:12', 4, 4, 1, 24),
			('17:39:58', 5, 5, 2, 25),
			('19:55:10', 1, 2, 3, 26),
			('21:28:33', 2, 7, 4, 27),
			('23:03:09', 3, 8, 5, 28),
			('00:44:44', 4, 9, 6, 29),
			('02:17:21', 5, 3, 7, 30),
			('04:48:03', 1, 1, 8, 31),
			('06:12:45', 2, 2, 1, 32),
			('08:59:27', 3, 3, 2, 33),
			('10:46:38', 4, 3, 3, 34),
			('13:33:00', 5, 5, 4, 35),
			('15:10:10', 1, 6, 5, 36),
			('17:22:22', 2, 7, 6, 37),
			('19:45:45', 3, 8, 7, 38),
			('21:59:59', 4, 9, 8, 39),
			('01:01:01', 5, 4, 1, 40);
            
            
SELECT * FROM Orders;


INSERT INTO MenuItem (MenuItemID, ItemName, ItemPrice)
VALUES		(1, 'Cheesburger', 8.99),
			(2, 'Veggie Burger', 7.49),
			(3, 'Chicken Sandwich', 9.25),
			(4, 'Grilled Cheese', 6.50),
			(5, 'Fish Tacos', 10.75),
			(6, 'Chicken Caesar Salad', 9.99),
			(7, 'Steak Burrito', 11.50),
			(8, 'Spaghetti Bolognese', 12.00),
			(9, 'Pepperoni Pizza Slice', 4.25),
			(10, 'Fried Chicken Wings', 8.75),
			(11, 'BBQ Pulled Pork Sandwich', 9.85),
			(12, 'Shrimp Po Boy', 10.99),
			(13, 'Bacon Double Cheeseburger', 11.45),
			(14, 'Tofu Stir Fry', 8.25),
			(15, 'Mac and Cheese', 7.99);
            
		
SELECT * FROM MenuItem;


INSERT INTO OrderItem (MenuItemID, OrderPrice, Quantity)
VALUES		(7, 11.50, 2),
			(3, 9.25, 1),
			(1, 8.99, 2),
			(5, 10.75, 1),
			(8, 12.00, 3),
			(2, 7.49, 1),
			(6, 9.99, 2),
			(10, 8.75, 2),
			(11, 9.85, 1),
			(9, 4.25, 3),
			(4, 6.50, 2),
			(12, 10.99, 1),
			(13, 11.45, 2),
			(14, 8.25, 2),
			(15, 7.99, 1),
			(1, 8.99, 1),
			(7, 11.50, 1),
			(6, 9.99, 1),
			(5, 10.75, 2),
			(3, 9.25, 2),
			(9, 4.25, 2),
			(8, 12.00, 1),
			(10, 8.75, 1),
			(2, 7.49, 3),
			(13, 11.45, 1),
			(4, 6.50, 1),
			(11, 9.85, 2),
			(14, 8.25, 1),
			(15, 7.99, 2),
			(12, 10.99, 2),
			(1, 8.99, 3),
			(6, 9.99, 3),
			(5, 10.75, 3),
			(2, 7.49, 2),
			(10, 8.75, 3),
			(3, 9.25, 3),
			(9, 4.25, 1),
			(7, 11.50, 3),
			(14, 8.25, 3),
			(15, 7.99, 3);
            
            
SELECT * FROM OrderItem;


INSERT INTO Subscription (CustomerID, SubscriptionID, ChargeDate, BeginTime, EndTime)
VALUES		(4, 9, '2024-03-16', '06:25:00', '08:35:00'),
			(1, 2, '2024-04-01', '07:00:00', '09:00:00'),
			(7, 5, '2024-04-15', '08:15:30', '10:30:45'),
			(12, 3, '2024-05-01', '09:45:00', '11:00:00'),
			(8, 1, '2024-03-20', '06:10:00', '08:00:00'),
			(6, 4, '2024-05-05', '07:30:00', '09:15:00'),
			(11, 6, '2024-05-10', '08:45:00', '10:45:00'),
			(14, 7, '2024-04-18', '09:00:00', '11:15:00'),
			(3, 8, '2024-03-25', '06:45:00', '08:50:00'),
			(9, 10, '2024-04-30', '07:50:00', '09:30:00'),
			(2, 11, '2024-03-22', '08:05:00', '10:10:00'),
			(5, 12, '2024-05-03', '09:20:00', '11:40:00'),
			(10, 13, '2024-03-29', '06:55:00', '08:30:00'),
			(13, 14, '2024-04-08', '07:40:00', '09:45:00'),
			(15, 15, '2024-05-12', '08:30:00', '10:15:00');
            
            
SELECT * FROM Subscription;


INSERT INTO Review (CustomerID, DriverID, Rating, ReviewTime)
VALUES		(1, 4, 3, '10:36:18'),
			(2, 5, 4, '11:22:45'),
			(3, 6, 5, '12:10:00'),
			(4, 7, 2, '09:15:30'),
			(5, 8, 1, '14:50:00'),
			(6, 9, 4, '13:05:20'),
			(7, 10, 5, '15:30:45'),
			(8, 11, 3, '10:00:00'),
			(9, 12, 2, '08:40:10'),
			(10, 13, 5, '16:10:00'),
			(11, 14, 4, '12:35:25'),
			(12, 15, 3, '11:55:55'),
			(13, 1, 2, '10:30:30'),
			(14, 2, 1, '09:25:00'),
			(15, 3, 5, '14:00:00'),
			(16, 4, 4, '10:45:00'),
			(17, 5, 3, '13:20:00'),
			(18, 6, 2, '08:15:00'),
			(19, 7, 1, '09:00:00'),
			(20, 8, 5, '17:30:00'),
			(21, 9, 4, '12:00:00'),
			(22, 10, 3, '11:45:00'),
			(23, 11, 2, '14:25:00'),
			(24, 12, 1, '13:15:00'),
			(25, 13, 5, '08:55:00'),
			(26, 14, 4, '09:35:00'),
			(27, 15, 3, '10:15:00'),
			(28, 1, 2, '11:05:00'),
			(29, 2, 1, '12:45:00'),
			(30, 3, 5, '13:30:00'),
			(31, 4, 4, '14:40:00'),
			(32, 5, 3, '15:10:00'),
			(33, 6, 2, '16:25:00'),
			(34, 7, 1, '17:15:00'),
			(35, 8, 5, '18:05:00'),
			(36, 9, 4, '19:00:00'),
			(37, 10, 3, '20:10:00'),
			(38, 11, 2, '21:20:00'),
			(39, 12, 1, '22:30:00'),
			(40, 13, 5, '23:45:00');
            
            
SELECT * FROM Review;


INSERT INTO CustomerService (CustomerID, OrderID, DriverID)
VALUES 		(2, 7, 4),
			(5, 12, 9),
			(8, 19, 3),
			(3, 4, 2),
			(10, 22, 6),
			(1, 1, 1),
			(6, 15, 11),
			(12, 28, 1),
			(4, 9, 6),
			(7, 17, 14),
			(9, 20, 15),
			(11, 30, 4),
			(14, 35, 8),
			(13, 32, 6),
			(15, 38, 1);


SELECT * FROM CustomerService;
        
        
INSERT INTO Payment (PaymentID, OrderID, OverallPrice, PaymentType)
VALUES 		(1, 8, 36.54, 'Card'),
			(2, 12, 22.10, 'Mobile'),
			(3, 5, 48.75, 'Card'),
			(4, 17, 15.99, 'Mobile'),
			(5, 9, 62.30, 'Card'),
			(6, 14, 27.80, 'Mobile'),
			(7, 2, 33.00, 'Card'),
			(8, 20, 41.25, 'Mobile'),
			(9, 11, 18.90, 'Card'),
			(10, 25, 59.10, 'Mobile'),
			(11, 6, 24.50, 'Card'),
			(12, 30, 39.99, 'Mobile'),
			(13, 19, 21.35, 'Card'),
			(14, 4, 45.60, 'Mobile'),
			(15, 3, 53.20, 'Card');
            
            
SELECT * FROM Payment;


INSERT INTO CardPayment (PaymentID, CardID, PrimaryCardFlag)
VALUES 		(3, 8, 'Y'),
			(5, 12, 'N'),
			(7, 4, 'Y'),
			(9, 15, 'N'),
			(1, 7, 'Y'),
			(3, 6, 'Y'),
			(15, 10, 'N'),
			(1, 1, 'Y'),
			(7, 14, 'N'),
			(9, 3, 'Y'),
			(2, 9, 'N'),
			(3, 11, 'Y'),
			(5, 13, 'Y'),
			(7, 5, 'N'),
			(9, 2, 'Y');

            
SELECT * FROM CardPayment;


INSERT INTO MobilePayment (PaymentID, MobileID, PrimaryMobileFlag)
VALUES		(2, 1, 'Y'),
			(4, 3, 'N'),
			(6, 5, 'Y'),
			(8, 7, 'Y'),
			(10, 2, 'N'),
			(12, 6, 'Y'),
			(13, 2, 'N'),
			(14, 4, 'Y'),
			(6, 9, 'N'),
			(8, 8, 'Y'),
			(2, 3, 'Y'),
			(2, 10, 'N'),
			(4, 11, 'Y'),
			(6, 12, 'Y'),
			(8, 13, 'N');
            
            
SELECT * FROM MobilePayment;


-- Q1. Which customers are currently "Active" subscribers, and what are their email addresses and phone numbers?
    
SELECT 
    c.CustomerID,
    concat(c.FirstName, ' ', c. LastName) as CustomerName,
    c.City,
    c.State,
    ce.EmailAddress,
    cp.PhoneNumber
FROM 
    Customers c
JOIN 
    CustomerEmailAddress ce ON c.CustomerID = ce.CustomerID AND ce.PrimaryEmailFlag = 'Y'
JOIN 
    CustomerPhoneNumber cp ON c.CustomerID = cp.CustomerID AND cp.PrimaryPhoneFlag = 'Y'
WHERE 
    c.CustomerType = 'Subscriber'
    AND c.OrderStatus = 'Active';


-- Q2. What is the total revenue generated by each marketing campaign?
	-- Purpose: Evaluate the ROI of advertising efforts by linking orders to campaign costs and payments.
    
SELECT 
    o.CampaignID,
    m.AdCost,
    COUNT(p.PaymentID) AS TotalOrders,
    SUM(p.OverallPrice) AS TotalRevenue
FROM 
    Orders o
JOIN 
    Payment p ON o.OrderID = p.OrderID
JOIN 
    Marketing m ON o.CampaignID = m.CampaignID
GROUP BY 
    o.CampaignID, m.AdCost
ORDER BY 
    TotalRevenue DESC;
    

-- Q3. Which restaurant has fulfilled the highest number of orders?
	-- Purpose: Identify high-performing restaurant partners or optimize logistics based on order volume.

SELECT *    
FROM Orders;

CREATE VIEW RestaurantOrders AS
SELECT R.RestaurantID,
    COUNT(DISTINCT O.OrderID) AS TotalOrders,
    SUM(OI.OrderPrice * OI.Quantity) AS TotalRevenue
FROM Restaurant AS R
JOIN Orders AS O ON R.RestaurantID = O.RestaurantID
JOIN OrderItem AS OI ON O.OrderID = OI.OrderID
GROUP BY R.RestaurantID
ORDER BY TotalRevenue DESC;


-- Q4. What is the average rating received by each driver, and which drivers have the highest and lowest ratings?
	-- Purpose: Assess driver performance for bonuses, coaching, or disciplinary actions.

SELECT *
FROM DriverRatings;
 
 Drop View DriverRatings;
 
CREATE VIEW DriverRatings AS
SELECT D.DriverID,
	CONCAT ( D.FirstName, ' ', D.LastName ) AS DriverName,
    SUM(R.Rating) AS TotalRatings,
	AVG(R.Rating) AS AverageRating
FROM Drivers AS D
LEFT OUTER JOIN Review AS R ON D.DriverID = R.DriverID
GROUP BY D.DriverID, D.FirstName, D.LastName
ORDER BY AverageRating DESC, TotalRatings DESC;


-- Q5. What are the most frequently ordered items on the menu, and how much revenue has each item generated?
	-- Purpose: Optimize the menu by promoting top sellers or removing underperforming items.

-- Q6. Which customers have submitted reviews with low ratings (e.g., 1 or 2), and which driver were they reviewing?
	-- Purpose: Investigate service quality issues and improve customer satisfaction.

-- Q7. What is the total number of subscriptions and average duration of subscription sessions per customer?
	-- Purpose: Understand customer usage patterns and subscription engagement.
    
SELECT 
    s.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(*) AS TotalSubscriptions,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, s.BeginTime, s.EndTime)) / 60, 2) AS AvgDurationHours
    
FROM Subscription s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY s.CustomerID, CustomerName
ORDER BY s.CustomerID;


-- Q8. How many orders were paid via card vs. mobile payment, and what is the total value of each payment method?
	-- Purpose: Analyze preferred payment methods and manage payment processing costs.
    
SELECT 
    'Card' AS PaymentType,
    COUNT(*) AS NumPayments,
    SUM(p.OverallPrice) AS TotalPaid
    
FROM Payment p
JOIN CardPayment cp ON p.PaymentID = cp.PaymentID

UNION

-- Mobile Payments
SELECT 
    'Mobile' AS PaymentType,
    COUNT(*) AS NumPayments,
    SUM(p.OverallPrice) AS TotalPaid
    
FROM Payment p
JOIN MobilePayment mp ON p.PaymentID = mp.PaymentID;

-- Q9. For each order, what is the itemized list of menu items, their prices, quantities, and total line cost?
	-- Purpose: Provide detailed receipts or support order auditing and analytics.
    
SELECT 
    O.OrderId,
    MI.ItemName,
    MI.ItemPrice,
    OI.Quantity,
    (MI.ItemPrice * OI.Quantity) AS LineTotal
FROM 
    Orders AS O
INNER JOIN 
    OrderItem AS OI ON O.OrderID = OI.OrderID
INNER JOIN 
    MenuItem AS MI ON OI.MenuItemID = MI.MenuItemID
ORDER BY
    O.OrderID;


DROP PROCEDURE IF EXISTS AddRestaurant;

DELIMITER //

CREATE PROCEDURE AddCustomer
(	 IN $CustomerType				VARCHAR(25),
     IN $OrderStatus				VARCHAR(25),
     IN	$FirstName					VARCHAR(25),
	 IN	$LastName					VARCHAR(25),
	 IN	$StreetAddress				VARCHAR(50),
	 IN	$City						VARCHAR(25),
	 IN	$State						CHAR(2),
	 IN	$ZipCode					VARCHAR(10)
)
BEGIN
	DECLARE $CustomerID MEDIUMINT UNSIGNED;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN	ROLLBACK; RESIGNAL; END;

START TRANSACTION;
	INSERT INTO Customers (CustomerType, OrderStatus, FirstName, LastName, StreetAddress, City, State, ZipCode)
    VALUES($CustomerType, $OrderStatus, $FirstName, $LastName, $StreetAddress, $City, $State, $ZipCode);
    
COMMIT;
END //
DELIMITER ;

Call AddCustomer
(	'Subscriber',
	'Pending',
	'David',
    'Henry',
    '567 Lane Drive',
    'Weber',
    'UT',
    '56389'
    );


DELIMITER //
CREATE PROCEDURE AddRestaurant
(	IN $StreetAddress			varchar(100),
	IN $City					varchar(50),
	IN $State					Char(2),
	IN $ZipCode					varchar(10),
	IN $PhoneNumber				varchar(17)
)
BEGIN
	DECLARE $RestaurantID MEDIUMINT UNSIGNED;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN	ROLLBACK; RESIGNAL; END;

START TRANSACTION;
	INSERT INTO Restaurant (StreetAddress, City, State, ZipCode, PhoneNumber)
    VALUES($StreetAddress, $City, $State, $ZipCode, $PhoneNumber);
    
COMMIT;
END //
DELIMITER ;

CALL AddRestaurant
( 
 '432 Oak St',
 'Austin',
 'TX', 
 '71583', 
 '970-958-5931'
);



DELIMITER //

CREATE PROCEDURE AddDriver
(	IN $DriverStatus 	varchar(25),
	IN $FirstName	 	varchar(25),
    IN $LastName		varchar(25),
    IN $PhoneNumber		varchar(17)
)

BEGIN
DECLARE $DriverID MEDIUMINT UNSIGNED;
DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN	ROLLBACK; RESIGNAL; END;

START TRANSACTION;
INSERT INTO Drivers (DriverStatus, FirstName, LastName, PhoneNumber)
Values($DriverStatus, $FirstName, $LastName, $PhoneNumber);

COMMIT;
END // 

DELIMITER ;

CALL AddDriver
('Available',
 'Dan',
 'Kenny',
 '4562849136'
 );
