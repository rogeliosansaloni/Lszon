DROP TABLE IF EXISTS Country CASCADE;
CREATE TABLE Country (
	CountryID SERIAL,
    Country VARCHAR (255),
    
    PRIMARY KEY (CountryID)
);

DROP TABLE IF EXISTS City CASCADE;
CREATE TABLE City (
	CountryID INTEGER,
    CityID SERIAL,
    City VARCHAR (255),
    Region VARCHAR (255),
    
    PRIMARY KEY (CountryID, CityID),
    FOREIGN KEY (CountryID) REFERENCES Country (CountryID)
);

DROP TABLE IF EXISTS Region CASCADE;
CREATE TABLE Region (
	RegionID INTEGER,
    RegionDescription VARCHAR (255),
    PRIMARY KEY (RegionID)
);

DROP TABLE IF EXISTS Territory CASCADE;
CREATE TABLE Territory (
	RegionID INTEGER,
    TerritoryID INTEGER,
    TerritoryDescription VARCHAR (255),
    
    PRIMARY KEY (RegionID, TerritoryID),
    FOREIGN KEY (RegionID) REFERENCES Region (RegionID)
);

DROP TABLE IF EXISTS Person CASCADE;
CREATE TABLE Person (
	PersonID INTEGER,
    Adress VARCHAR (255),
	PostalCode VARCHAR (255),
	FirstName VARCHAR (255),
	LastName VARCHAR (255),
	Title VARCHAR (255),
	CountryID INTEGER,
	CityID INTEGER,

    PRIMARY KEY (PersonID),
    FOREIGN KEY (CountryID, CityID) REFERENCES City (CountryID, CityID)
);

DROP TABLE IF EXISTS Employee CASCADE;
CREATE TABLE Employee (
	EmployeeID INTEGER,
	Extension INTEGER,
	Notes VARCHAR (1000),
	PhotoPath VARCHAR (255),
	BirthDate DATE,
	HireDate DATE,
	TitleOfCourtesy VARCHAR (255),

    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmployeeID) REFERENCES Person (PersonID)
);

DROP TABLE IF EXISTS Relates CASCADE;
CREATE TABLE Relates (
	EmployeeID INTEGER,
    TerritoryID INTEGER,
    RegionID INTEGER,
    
    PRIMARY KEY (EmployeeID, TerritoryID, RegionID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID),
    FOREIGN KEY (TerritoryID, RegionID) REFERENCES Territory (TerritoryID, RegionID)
);
    
DROP TABLE IF EXISTS Reports CASCADE;
CREATE TABLE Reports (
	EmployeeID INTEGER,
	EmployeeReportedID INTEGER,

    PRIMARY KEY (EmployeeID, EmployeeReportedID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID),
    FOREIGN KEY (EmployeeReportedID) REFERENCES Employee (EmployeeID)
);
    
DROP TABLE IF EXISTS Customer CASCADE;
CREATE TABLE Customer (
	CustomerID INTEGER,

    PRIMARY KEY (CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES Person (PersonID)
);

DROP TABLE IF EXISTS Company CASCADE;
CREATE TABLE Company (
	CompanyID SERIAL,
    CompanyName VARCHAR (255),
    
    PRIMARY KEY (CompanyID)
);

DROP TABLE IF EXISTS Shipper CASCADE;
CREATE TABLE Shipper (
	ShipperID INTEGER,
    
    PRIMARY KEY (ShipperID),
    FOREIGN KEY (ShipperID) REFERENCES Company (CompanyID)
);

DROP TABLE IF EXISTS Supplier CASCADE;
CREATE TABLE Supplier (
	SupplierID INTEGER,
    SupplierAdress VARCHAR (255),
	supplierpostalcode VARCHAR (255),
	SupplierHomePage VARCHAR (255),
	SupplierContactName VARCHAR (255),
	SupplierContactTitle VARCHAR (255),
	CountryID INTEGER,
	CityID INTEGER,

    PRIMARY KEY (SupplierID),
    FOREIGN KEY (SupplierID) REFERENCES Company (CompanyID),
    FOREIGN KEY (CountryID, CityID) REFERENCES City (CountryID, CityID)
);

DROP TABLE IF EXISTS Phone CASCADE;
CREATE TABLE Phone (
	PhoneID SERIAL,
   	PhoneNumber VARCHAR (255),
	PersonID INTEGER,
    CompanyID INTEGER,
    
    PRIMARY KEY (PhoneID),
    FOREIGN KEY (PersonID) REFERENCES Person (PersonID),
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);

DROP TABLE IF EXISTS Inventory CASCADE;
CREATE TABLE Inventory (
	InventoryID SERIAL,
    CategoryName VARCHAR (255),
	CategoryDescription VARCHAR (255),
    
    PRIMARY KEY (InventoryID)
);

DROP TABLE IF EXISTS Product CASCADE;
CREATE TABLE Product (
	InventoryID INTEGER,
    ProductID SERIAL,
    ProductName VARCHAR (255),
    QuantityPerUnitOfProduct VARCHAR (255),
	UnitPriceOfProduct FLOAT,
	UnitsInStockOfProduct INTEGER,
	UnitsOnOrderOfProduct INTEGER,
	ProductReorderLevel INTEGER,
	DiscontinuedProduct BOOLEAN,
	SupplierID INTEGER,
    
    PRIMARY KEY (InventoryID, ProductID),
    FOREIGN KEY (InventoryID) REFERENCES Inventory (InventoryID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID)
);

DROP TABLE IF EXISTS OrderShip CASCADE;
CREATE TABLE OrderShip (
	OrderShipID SERIAL,
    OrderDate DATE,
	RequiredDate DATE,
	ShippedDate DATE,
    OrderShipName VARCHAR (255),
	OrderFreight FLOAT,
	OrderShipAddress VARCHAR (255),
	OrderShipPostalCode VARCHAR (255),
    CityID INTEGER,
    CountryID INTEGER,

    PRIMARY KEY (OrderShipID),
    FOREIGN KEY (CityID, CountryID) REFERENCES City (CityID, CountryID)
);

DROP TABLE IF EXISTS Sends CASCADE;
CREATE TABLE Sends (
	OrderShipID INTEGER,
    ShipperID INTEGER,
    InventoryID INTEGER,
	ProductID INTEGER,
    CustomerID INTEGER,
	EmployeeID INTEGER,
    OrderUnitPrice FLOAT,
    OrderQuantity INTEGER,
	OrderDiscount FLOAT,

    PRIMARY KEY (OrderShipID,ShipperID, InventoryID, ProductID, CustomerID, EmployeeID),
    FOREIGN KEY (OrderShipID) REFERENCES OrderShip (OrderShipID),
    FOREIGN KEY (ShipperID) REFERENCES Shipper (ShipperID),
    FOREIGN KEY (InventoryID, ProductID) REFERENCES Product (InventoryID, ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
);

DROP TABLE IF EXISTS CustomersImportation;
CREATE TABLE CustomersImportation (
	OrderDate DATE,
	RequiredDate DATE,
	ShippedDate DATE,
	OrderFreight FLOAT,
    OrderShipName VARCHAR (255),
	OrderShipAddress VARCHAR (255),
	OrderShipCity VARCHAR (255),
    OrderShipRegion VARCHAR (255),
	OrderShipPostalCode VARCHAR (255),
	OrderShipCountry VARCHAR (255),
	CompanyName VARCHAR (255),
    ContactName VARCHAR (255),
    ContactTitle VARCHAR (255),
	Adress VARCHAR (255),
    City VARCHAR (255),
    Region VARCHAR (255),
    PostalCode VARCHAR (255),
    Country VARCHAR (255),
    Phone VARCHAR (255),
    Phone2 VARCHAR (255)
);

DROP TABLE IF EXISTS EmployeesImportation;
CREATE TABLE EmployeesImportation (
	OrderDate DATE,
	RequiredDate DATE,
	ShippedDate DATE,
	OrderFreight FLOAT,
    OrderShipName VARCHAR (255),
	OrderShipAddress VARCHAR (255),
	OrderShipCity VARCHAR (255),
    OrderShipRegion VARCHAR (255),
	OrderShipPostalCode VARCHAR (255),
	OrderShipCountry VARCHAR (255),
    EmployeeID INTEGER,
    LastName VARCHAR (255),
    FirstName VARCHAR (255),
    Title VARCHAR (255),
    TitleOfCourtesy VARCHAR (255),
    BirthDate DATE,
    HireDate DATE,
    Adress VARCHAR (255),
    City VARCHAR (255),
    Region VARCHAR (255),
    PostalCode VARCHAR (255),
    Country VARCHAR (255),
    HomePhone VARCHAR (255),
    Extension INTEGER,
    Photo VARCHAR (255),
    Notes VARCHAR (1000),
    ReportsTo INTEGER,
    PhotoPath VARCHAR (255),
    EmployeeID_1 INTEGER,
    TerritoryID INTEGER,
    TerritoryID_2 INTEGER,
    TerritoryDescription VARCHAR (255),
    RegionID INTEGER,
    RegionID_3 INTEGER,
    RegionDescription VARCHAR (255)
);

DROP TABLE IF EXISTS ProductsImportation;
CREATE TABLE ProductsImportation (
	OrderDate DATE,
	RequiredDate DATE,
	ShippedDate DATE,
	OrderFreight FLOAT,
    OrderShipName VARCHAR (255),
	OrderShipAddress VARCHAR (255),
	OrderShipCity VARCHAR (255),
    OrderShipRegion VARCHAR (255),
	OrderShipPostalCode VARCHAR (255),
	OrderShipCountry VARCHAR (255),
    OrderUnitPrice FLOAT,
    OrderQuantity INTEGER,
	OrderDiscount FLOAT,
    shippercompanyname VARCHAR (255),
    ShipperPhone VARCHAR (255),
    ProductName VARCHAR(255),
    QuantityPerUnitOfProduct VARCHAR (255),
	UnitPriceOfProduct FLOAT,
	UnitsInStockOfProduct INTEGER,
	UnitsOnOrderOfProduct INTEGER,
	ProductReorderLevel INTEGER,
	DiscontinuedProduct INTEGER,
    SupplierCompanyName VARCHAR (255),
    SupplierContactName VARCHAR (255),
    SupplierContactTitle VARCHAR (255),
    SupplierAdress VARCHAR (255),
    SupplierCity VARCHAR (255),
    SupplierRegion VARCHAR (255),
    supplierpostalcode VARCHAR (255),
    SupplierCountry VARCHAR (255),
    SupplierPhone VARCHAR (255),
    SupplierPhone2 VARCHAR (255),
    SupplierHomePage VARCHAR (255),
    CategoryName VARCHAR (255),
    CategoryDescription VARCHAR (255),
    CategoryPicture VARCHAR (255)   
);

--Inserim la informaciÃ³ dels arxius .csv a les taules d'importaciÃ³
COPY CustomersImportation(OrderDate,RequiredDate,ShippedDate,OrderFreight,
OrderShipName,OrderShipAddress,OrderShipCity,OrderShipRegion,
OrderShipPostalCode,OrderShipCountry ,
CompanyName,ContactName,ContactTitle,Adress,City,Region,PostalCode,Country,
Phone,Phone2) FROM '/Users/Shared/CustomersOrders.csv' 
WITH CSV HEADER DELIMITER AS ',';
COPY EmployeesImportation(OrderDate,RequiredDate,ShippedDate,OrderFreight,
OrderShipName,OrderShipAddress,OrderShipCity,OrderShipRegion,
OrderShipPostalCode,OrderShipCountry,
    EmployeeID,LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,
    Adress,City,Region,PostalCode,Country,HomePhone,Extension,
    Photo,Notes,ReportsTo,PhotoPath,EmployeeID_1,
    TerritoryID,TerritoryID_2,TerritoryDescription,RegionID,RegionID_3,
    RegionDescription) FROM '/Users/Shared/EmployeesSales.csv'
     WITH CSV HEADER DELIMITER AS ',';
COPY ProductsImportation(OrderDate,RequiredDate,ShippedDate,OrderFreight,
OrderShipName,OrderShipAddress,OrderShipCity,OrderShipRegion,
OrderShipPostalCode,OrderShipCountry,OrderUnitPrice,
    OrderQuantity,OrderDiscount,shippercompanyname,ShipperPhone,ProductName,
    QuantityPerUnitOfProduct,UnitPriceOfProduct,UnitsInStockOfProduct,
    UnitsOnOrderOfProduct,ProductReorderLevel,DiscontinuedProduct,
    SupplierCompanyName,SupplierContactName,SupplierContactTitle,SupplierAdress,
    SupplierCity,SupplierRegion,supplierpostalcode,
    SupplierCountry,SupplierPhone,SupplierPhone2,SupplierHomePage,
    CategoryName,CategoryDescription,CategoryPicture) FROM 
    '/Users/Shared/ProductsOrdered_NEW.csv' WITH CSV HEADER DELIMITER AS ',';

--Inserim a les taules del nou model la informació de les taules d'importació

--Creem Aux_country_city per inserir els diferents Country i City i evitar repeticions
DROP TABLE IF EXISTS Aux_country_city;
CREATE TABLE Aux_country_city (
	Country VARCHAR (255),
    City VARCHAR (255),
    Region VARCHAR (255)
);

INSERT INTO Aux_country_city (Country,City,Region)
SELECT OrderShipCountry, OrderShipCity, OrderShipRegion
FROM CustomersImportation;

INSERT INTO Aux_country_city (Country,City,Region)
SELECT Country, City, Region
FROM CustomersImportation;

INSERT INTO Aux_country_city (Country,City,Region)
SELECT OrderShipCountry, OrderShipCity, OrderShipRegion
FROM EmployeesImportation;

INSERT INTO Aux_country_city (Country,City,Region)
SELECT Country, City, Region
FROM EmployeesImportation;

INSERT INTO Aux_country_city (Country,City,Region)
SELECT OrderShipCountry, OrderShipCity, OrderShipRegion
FROM ProductsImportation;

INSERT INTO Aux_country_city (Country,City,Region)
SELECT SupplierCountry, SupplierCity, SupplierRegion
FROM ProductsImportation;

--Inserim el noms dels països a Country
INSERT INTO Country (Country)
SELECT DISTINCT Country
FROM Aux_country_city;

--Inserim els noms de les ciutats a City
INSERT INTO City (CountryID,City,Region)
SELECT DISTINCT Country.CountryID, Aux_country_city.City, Aux_country_city.Region
FROM Aux_country_city NATURAL JOIN Country;

--Omplim la taula Region
INSERT INTO Region (RegionID,RegionDescription)
SELECT DISTINCT RegionID, RegionDescription
FROM EmployeesImportation;

--Omplim la taula Territory
INSERT INTO Territory (RegionID,TerritoryID,TerritoryDescription)
SELECT DISTINCT Region.RegionID,EmployeesImportation.TerritoryID,
EmployeesImportation.TerritoryDescription
FROM Region NATURAL JOIN EmployeesImportation;

SELECT * FROM Territory;

--Omplim la taula Aux_person per poder omplir posteriorment la taula Person
DROP TABLE IF EXISTS Aux_person CASCADE;
CREATE TABLE Aux_person (
    CustomerID SERIAL,
    Name VARCHAR (255),
    FirstName VARCHAR (255),
    LastName VARCHAR (255),
    Title VARCHAR (255),
	Adress VARCHAR (255),
    City VARCHAR (255),
    Region VARCHAR (255),
    PostalCode VARCHAR (255),
    Country VARCHAR (255),
    EmployeeID INTEGER,
    HomePhone VARCHAR (255),
    Phone VARCHAR (255),
    Phone2 VARCHAR (255)
);

--Primer posem la informació dels Employees
INSERT INTO Aux_person (Name,FirstName,LastName,Title,Adress,City,Region,
PostalCode,Country,EmployeeID,HomePhone,Phone,Phone2)
SELECT DISTINCT NULL,FirstName,LastName,Title,Adress,City,Region,PostalCode,
Country,EmployeeID,HomePhone,NULL,NULL
FROM EmployeesImportation;

--Com que els ID dels employees ens els facilita el fitxer csv, cal que els 
--següents PersonID, que són els dels customers, 
--comencen a partir del major ID dels employees per evitar repeticions.
--Per a això, fixem el inici del serial que representa els ID dels customers 
--al màxim ID dels employees.
UPDATE Aux_person SET CustomerID = (SELECT MAX(EmployeeID) FROM Aux_person 
GROUP BY EmployeeID ORDER BY EmployeeID DESC LIMIT 1);

--Ara ja podem inserir la info dels customers. Dividim el nom complert dels 
--customers en nom i cognom segons l'espai que hi ha entre els dos. 
--En el cas d'haver més de 1 espai, vol dir que la persona té un nom compost, 
--per tant fem 3 divisions i juntem les dos primeres per tal de tenir 
--el nom complert i el cognom separats.
INSERT INTO Aux_person (Name,FirstName,LastName,Title,Adress,City,Region,PostalCode,
Country,EmployeeID,HomePhone,Phone,Phone2)
SELECT DISTINCT ContactName, SPLIT_PART(ContactName, ' ', 1),SPLIT_PART(ContactName, ' ', 2),
ContactTitle,Adress,City,Region,PostalCode,Country,-1,NULL,Phone,Phone2
FROM CustomersImportation
WHERE LENGTH(ContactName) - LENGTH(REPLACE(ContactName, ' ', '')) < 2;

INSERT INTO Aux_person (Name,FirstName,LastName,Title,Adress,City,Region,PostalCode,
Country,EmployeeID,HomePhone,Phone,Phone2)
SELECT DISTINCT ContactName, CONCAT(SPLIT_PART(ContactName, ' ', 1),' ',
SPLIT_PART(ContactName, ' ', 2)),SPLIT_PART(ContactName, ' ', 3), ContactTitle,
Adress,City,Region,PostalCode,Country,-1,NULL,Phone,Phone2
FROM CustomersImportation
WHERE LENGTH(ContactName) - LENGTH(REPLACE(ContactName, ' ', '')) >= 2;

--Comprovem a les dades que moltes Region valen NULL.Cal canviar els valors NULL 
--de Regionja que sino al fer el NATURAL JOIN no es relacionen les taules correctament.
--Canviem el valor a 'No te Region' per a que es pugui entendre fàcilment.
UPDATE City
SET Region = 'No té Region'
WHERE Region IS NULL;

UPDATE Aux_person
SET Region = 'No té Region'
WHERE Region IS NULL;

--Inserim els employees en la taula Person si EmployeeID és major que 0, ja que sinó 
--es tracta d un costumer
INSERT INTO Person (PersonID,FirstName,LastName,Title,Adress,PostalCode,CountryID,CityID)
SELECT DISTINCT Aux_person.EmployeeID,Aux_person.FirstName,Aux_person.LastName,Aux_person.Title,
Aux_person.Adress,Aux_person.PostalCode,City.CountryID, City.CityID
FROM Aux_person NATURAL JOIN City
WHERE EmployeeID >= 0;

--Inserim els customers si CustomerID és major o igual a 10, ja que sinó és un employee
INSERT INTO Person (PersonID,FirstName,LastName,Title,Adress,PostalCode,CountryID,CityID)
SELECT DISTINCT Aux_person.CustomerID,Aux_person.FirstName,Aux_person.LastName,
Aux_person.Title,Aux_person.Adress,Aux_person.PostalCode,City.CountryID, City.CityID
FROM Aux_person NATURAL JOIN City
WHERE CustomerID >= 10;

INSERT INTO Employee (EmployeeID,Extension,Notes,PhotoPath,BirthDate,HireDate,TitleOfCourtesy)
SELECT DISTINCT Person.PersonID,EmployeesImportation.Extension,EmployeesImportation.Notes,
EmployeesImportation.PhotoPath,EmployeesImportation.BirthDate,EmployeesImportation.HireDate,
EmployeesImportation.TitleOfCourtesy
FROM Person JOIN EmployeesImportation ON Person.PersonID = EmployeesImportation.EmployeeID;

INSERT INTO Relates (EmployeeID, TerritoryID, RegionID)
SELECT DISTINCT E.EmployeeID, T.TerritoryID, T.RegionID
FROM EmployeesImportation NATURAL JOIN Employee AS E NATURAL JOIN Territory AS T;

--Comprovem a les dades que un dels customers té el codi postal a NULL i molts tenen Phone2 
--també NULL, per tant tenim que canviar el valor de 
--NULL per poder inserir correctament la informació a Customer. 
--Canviem NULL a '0' a 'No té PostalCode' i 'No té Phone2' per a que es pugui entendre fàcilment.
UPDATE CustomersImportation
SET PostalCode = 'No té PostalCode'
WHERE PostalCode IS NULL;

UPDATE Person
SET PostalCode = 'No té PostalCode'
WHERE PostalCode IS NULL;

INSERT INTO Customer (CustomerID)
SELECT DISTINCT Person.PersonID
FROM Person JOIN Aux_person ON Aux_person.CustomerID = Person.PersonID;

--Inserim a la taula Phone els telefons dels Customers i els seus id corresponents
INSERT INTO Phone (PhoneNumber,PersonID)
SELECT DISTINCT Aux_person.HomePhone, Person.PersonID
FROM Aux_person JOIN Person ON Aux_person.EmployeeID = Person.PersonID WHERE Aux_person.HomePhone IS NOT NULL;

INSERT INTO Phone (PhoneNumber, PersonID)
SELECT DISTINCT Aux_person.Phone, Person.PersonID
FROM Aux_person JOIN Person ON Aux_person.CustomerID = Person.PersonID WHERE Aux_person.Phone IS NOT NULL;

INSERT INTO Phone (PhoneNumber,PersonID)
SELECT DISTINCT Aux_person.Phone2, Person.PersonID
FROM Aux_person JOIN Person ON Aux_person.CustomerID = Person.PersonID WHERE Aux_person.Phone2 IS NOT NULL;

--Omplim la taula Reports
INSERT INTO Reports (EmployeeID, EmployeeReportedID)
SELECT DISTINCT E1.EmployeeID, E2.EmployeeID
FROM EmployeesImportation JOIN Employee AS E1 ON E1.EmployeeID = EmployeesImportation.EmployeeID
JOIN Employee AS E2 ON E2.EmployeeID = EmployeesImportation.ReportsTo;

--Creem la taula Aux_Company per a inserir els noms dels Shippers i els Suppliers i evitar repeticions
DROP TABLE IF EXISTS Aux_Company CASCADE;
CREATE TABLE Aux_Company (
    CompanyName VARCHAR (255)    
);

INSERT INTO Aux_Company (CompanyName)
SELECT DISTINCT CompanyName
FROM CustomersImportation;

INSERT INTO Aux_Company (CompanyName)
SELECT DISTINCT shippercompanyname
FROM ProductsImportation;

INSERT INTO Aux_Company (CompanyName)
SELECT DISTINCT SupplierCompanyName
FROM ProductsImportation;

--Omplim la taula Company a partir de Aux_Company
INSERT INTO Company (CompanyName)
SELECT DISTINCT CompanyName
FROM Aux_Company;

--Omplim la taula Shipper
INSERT INTO Shipper (ShipperID)
SELECT DISTINCT Company.CompanyID
FROM Company JOIN ProductsImportation ON Company.CompanyName = ProductsImportation.shippercompanyname;

--Comprovem a les dades que moltes SupplierRegion i SupplierHomePage valen NULL. Cal canviar el valor de 
--NULL de SupplierRegion i SupplierHomePage ja que sino al fer el JOIN no es relacionen les taules correctament.
--Canviem el valor a 'No te Region' i 'No té HomePage' per a que es pugui entendre fàcilment.
UPDATE ProductsImportation
SET SupplierRegion = 'No té Region'
WHERE SupplierRegion IS NULL;

UPDATE ProductsImportation
SET SupplierHomePage = 'No té HomePage'
WHERE SupplierHomePage IS NULL;

--Omplim la taula Supplier
INSERT INTO Supplier (SupplierID, SupplierAdress, supplierpostalcode, SupplierHomePage, 
SupplierContactName, SupplierContactTitle, CountryID, CityID)
SELECT DISTINCT Company.CompanyID, PI.SupplierAdress, PI.supplierpostalcode, PI.SupplierHomePage, 
PI.SupplierContactName, PI.SupplierContactTitle, City.CountryID, City.CityID
FROM Company JOIN ProductsImportation AS PI ON Company.CompanyName = PI.SupplierCompanyName 
JOIN City ON City.City = PI.SupplierCity AND City.Region = PI.SupplierRegion;

--Inserim a la taula Phone els telefons dels Shippers i els seus id corresponents
INSERT INTO Phone (PhoneNumber,CompanyID)
SELECT DISTINCT ProductsImportation.ShipperPhone, Company.CompanyID
FROM ProductsImportation JOIN Company ON Company.CompanyName = ProductsImportation.shippercompanyname 
WHERE ProductsImportation.ShipperPhone IS NOT NULL;

INSERT INTO Phone (PhoneNumber,CompanyID)
SELECT DISTINCT ProductsImportation.SupplierPhone, Company.CompanyID
FROM ProductsImportation JOIN Company ON Company.CompanyName = ProductsImportation.SupplierCompanyName 
WHERE ProductsImportation.SupplierPhone IS NOT NULL;

INSERT INTO Phone (PhoneNumber,CompanyID)
SELECT DISTINCT ProductsImportation.SupplierPhone2, Company.CompanyID
FROM ProductsImportation JOIN Company ON Company.CompanyName = ProductsImportation.SupplierCompanyName 
WHERE ProductsImportation.SupplierPhone2 IS NOT NULL;

--Omplim la taula Inventory
INSERT INTO Inventory (CategoryName, CategoryDescription)
SELECT DISTINCT ProductsImportation.CategoryName, ProductsImportation.CategoryDescription
FROM ProductsImportation;

--Inserim la informació a Product, de forma que inserim TRUE quan DiscontinuedProduct val 1 i FALSE 
--quan DiscontinuedProduct val 0
INSERT INTO Product (InventoryID, ProductName, QuantityPerUnitOfProduct, UnitPriceOfProduct, UnitsInStockOfProduct, 
UnitsOnOrderOfProduct, ProductReorderLevel, DiscontinuedProduct, SupplierID)
SELECT DISTINCT I.InventoryID, PI.ProductName, PI.QuantityPerUnitOfProduct, PI.UnitPriceOfProduct, PI.UnitsInStockOfProduct, 
PI.UnitsOnOrderOfProduct, PI.ProductReorderLevel, TRUE, S.SupplierID
FROM Inventory AS I JOIN ProductsImportation AS PI ON I.CategoryName = PI.CategoryName 
AND I.CategoryDescription = PI.CategoryDescription JOIN Supplier AS S ON PI.SupplierAdress = S.SupplierAdress 
AND PI.supplierpostalcode = S.supplierpostalcode AND PI.SupplierHomePage = S.SupplierHomePage 
AND PI.SupplierContactName = S.SupplierContactName AND PI.SupplierContactTitle = S.SupplierContactTitle
WHERE PI.DiscontinuedProduct = 1;

INSERT INTO Product (InventoryID, ProductName, QuantityPerUnitOfProduct, UnitPriceOfProduct, UnitsInStockOfProduct, 
UnitsOnOrderOfProduct, ProductReorderLevel, DiscontinuedProduct, SupplierID)
SELECT DISTINCT I.InventoryID, PI.ProductName, PI.QuantityPerUnitOfProduct, PI.UnitPriceOfProduct, PI.UnitsInStockOfProduct, 
PI.UnitsOnOrderOfProduct, PI.ProductReorderLevel, FALSE, S.SupplierID
FROM Inventory AS I JOIN ProductsImportation AS PI ON I.CategoryName = PI.CategoryName 
AND I.CategoryDescription = PI.CategoryDescription JOIN Supplier AS S ON PI.SupplierAdress = S.SupplierAdress 
AND PI.supplierpostalcode = S.supplierpostalcode AND PI.SupplierHomePage = S.SupplierHomePage 
AND PI.SupplierContactName = S.SupplierContactName AND PI.SupplierContactTitle = S.SupplierContactTitle
WHERE PI.DiscontinuedProduct = 0;

--Creem les taules AuxCustomers, AuxEmployees i AuxProducts  per a inserir només la 
--informació que ens interesa per a OrderShip i Sends
DROP TABLE IF EXISTS AuxCustomers;
CREATE TABLE AuxCustomers (
	OrderDate DATE,
	RequiredDate DATE,
	ShippedDate DATE,
	OrderFreight FLOAT,
    OrderShipName VARCHAR (255),
	OrderShipAddress VARCHAR (255),
	OrderShipCity VARCHAR (255),
    OrderShipRegion VARCHAR (255),
	OrderShipPostalCode VARCHAR (255),
	OrderShipCountry VARCHAR (255),
    Phone VARCHAR (255),
    Phone2 VARCHAR (255)
);

DROP TABLE IF EXISTS AuxEmployees;
CREATE TABLE AuxEmployees (
	OrderDate DATE,
	RequiredDate DATE,
	ShippedDate DATE,
	OrderFreight FLOAT,
    OrderShipName VARCHAR (255),
	OrderShipAddress VARCHAR (255),
	OrderShipCity VARCHAR (255),
    OrderShipRegion VARCHAR (255),
	OrderShipPostalCode VARCHAR (255),
	OrderShipCountry VARCHAR (255),
    EmployeeID INTEGER
);

DROP TABLE IF EXISTS AuxProducts;
CREATE TABLE AuxProducts (
	OrderDate DATE,
	RequiredDate DATE,
	ShippedDate DATE,
	OrderFreight FLOAT,
    OrderShipName VARCHAR (255),
	OrderShipAddress VARCHAR (255),
	OrderShipCity VARCHAR (255),
    OrderShipRegion VARCHAR (255),
	OrderShipPostalCode VARCHAR (255),
	OrderShipCountry VARCHAR (255),
    OrderUnitPrice FLOAT,
    OrderQuantity INTEGER,
	OrderDiscount FLOAT,
    ProductName VARCHAR(255),
    shippercompanyname VARCHAR (255)
);

INSERT INTO AuxCustomers(OrderDate, RequiredDate, ShippedDate, OrderShipName, OrderFreight, 
OrderShipAddress, OrderShipCity, OrderShipRegion,OrderShipPostalCode, OrderShipCountry, Phone, Phone2)
SELECT DISTINCT OrderDate, RequiredDate, ShippedDate, OrderShipName, OrderFreight, OrderShipAddress, 
OrderShipCity, OrderShipRegion, OrderShipPostalCode, OrderShipCountry, Phone, Phone2
FROM CustomersImportation;

INSERT INTO AuxEmployees(OrderDate, RequiredDate, ShippedDate, OrderShipName, OrderFreight, 
OrderShipAddress, OrderShipCity, OrderShipRegion, OrderShipPostalCode, OrderShipCountry, EmployeeID)                
SELECT DISTINCT OrderDate, RequiredDate, ShippedDate, OrderShipName, OrderFreight, OrderShipAddress, 
OrderShipCity, OrderShipRegion, OrderShipPostalCode, OrderShipCountry, EmployeeID
FROM EmployeesImportation;

INSERT INTO AuxProducts(OrderDate, RequiredDate, ShippedDate, OrderShipName, OrderFreight, OrderShipAddress, 
OrderShipCity, OrderShipRegion,OrderShipPostalCode, OrderShipCountry, OrderUnitPrice, OrderQuantity, OrderDiscount, ProductName, shippercompanyname)                        
SELECT DISTINCT OrderDate, RequiredDate, ShippedDate, OrderShipName, OrderFreight, OrderShipAddress, OrderShipCity, 
OrderShipRegion,OrderShipPostalCode, OrderShipCountry, OrderUnitPrice, OrderQuantity, OrderDiscount, ProductName, shippercompanyname
FROM ProductsImportation;

--Comprovem a les dades que moltes OrderShipRegion i ShippedDate valen NULL. Cal canviar 
--aquests valors ja que sino al fer el NATURAL JOIN no es relacionen les taules correctament.
----Canviem el valor a 'No te Region' per a que es pugui entendre fàcilment i possem ShippedDate 
--a la màxima data possible per evitar confusions.
UPDATE AuxCustomers
SET OrderShipRegion = 'No té Region'
WHERE OrderShipRegion IS NULL;

UPDATE AuxEmployees
SET OrderShipRegion = 'No té Region'
WHERE OrderShipRegion IS NULL;

UPDATE AuxProducts
SET OrderShipRegion = 'No té Region'
WHERE OrderShipRegion IS NULL;

UPDATE AuxCustomers
SET ShippedDate = '9999-12-31'
WHERE ShippedDate IS NULL;

UPDATE AuxEmployees
SET ShippedDate = '9999-12-31'
WHERE ShippedDate IS NULL;

UPDATE AuxProducts
SET ShippedDate = '9999-12-31'
WHERE ShippedDate IS NULL;

--Ara inserim la informació a OrderShip
INSERT INTO OrderShip (OrderDate, RequiredDate, ShippedDate, OrderShipName, OrderFreight, 
OrderShipAddress, OrderShipPostalCode, CityID, CountryID)
SELECT DISTINCT AP.OrderDate, AP.RequiredDate, AP.ShippedDate, AP.OrderShipName, AP.OrderFreight, 
AP.OrderShipAddress, AP.OrderShipPostalCode, C.CityID, C.CountryID
FROM AuxProducts AS AP JOIN City AS C ON AP.OrderShipCity = C.City AND AP.OrderShipRegion = C.Region;

--Inserim la informació a la taula Sends
INSERT INTO Sends (OrderShipID, ShipperID, InventoryID, ProductID, CustomerID, EmployeeID, OrderUnitPrice, 
OrderQuantity, OrderDiscount)
SELECT O.OrderShipID, S.ShipperID, P.InventoryID, P.ProductID, CU.CustomerID, E.EmployeeID, AP.OrderUnitPrice, 
AP.OrderQuantity, AP.OrderDiscount
FROM AuxProducts AS AP JOIN AuxEmployees AS AE ON AP.OrderDate=AE.OrderDate AND AP.RequiredDate=AE.RequiredDate 
AND AP.ShippedDate=AE.ShippedDate
AND AP.OrderShipName=AE.OrderShipName JOIN AuxCustomers AS AC ON AP.OrderDate=AC.OrderDate 
AND AP.RequiredDate=AC.RequiredDate AND AP.ShippedDate=AC.ShippedDate
AND AP.OrderShipName=AC.OrderShipName JOIN OrderShip AS O ON AP.OrderDate=O.OrderDate AND AP.RequiredDate=O.RequiredDate 
AND AP.ShippedDate=O.ShippedDate
AND AP.OrderShipName=O.OrderShipName JOIN Company AS C ON C.CompanyName = AP.shippercompanyname JOIN Shipper AS S 
ON C.CompanyID = S.ShipperID 
JOIN Product AS P ON AP.ProductName = P.ProductName JOIN Aux_person ON AC.phone=Aux_person.phone JOIN Customer AS CU 
ON Aux_person.CustomerID = CU.CustomerID
JOIN Employee AS E ON AE.EmployeeID = E.EmployeeID;

--Query 1
SELECT P.FirstName AS "FirstName", P.LastName AS "LastName", COUNT(S.OrderDiscount) AS "Time has Discounted", 
concat(SUM(S.OrderDiscount)*100, '%') AS "Sum Of Discounts"
FROM Person AS P JOIN Employee AS E ON P.PersonID = E.EmployeeID JOIN Sends AS S ON S.EmployeeID = E.EmployeeID
JOIN OrderShip AS O ON O.OrderShipID = S.OrderShipID JOIN City AS C ON O.CityID = C.CityID
WHERE S.OrderDiscount <> 0 AND P.CityID = O.CityID
GROUP BY P.FirstName, P.LastName, S.EmployeeID, C.City, O.CityID
ORDER BY "Time has Discounted" DESC LIMIT 1;

--Query 2
SELECT P.FirstName AS "FirstName", P.LastName AS "LastName", AVG(S.OrderDiscount) AS Proportion
FROM Person AS P JOIN Employee AS E ON P.PersonID = E.EmployeeID JOIN Sends AS S ON S.EmployeeID = E.EmployeeID
GROUP BY P.FirstName, P.LastName
ORDER BY Proportion DESC LIMIT 1;

--Query 3
SELECT O.OrderShipID AS "OrderID", O.OrderShipName AS "CompanyName",  O.OrderDate AS "OrderDate", 
SUM(S.OrderUnitPrice * S.OrderQuantity * (1 - S.OrderDiscount)) AS "Subtotal"
FROM OrderShip AS O JOIN Sends AS S ON S.OrderShipID = O.OrderShipID JOIN Product AS P ON P.ProductID = S.ProductID
GROUP BY O.OrderShipID, O.OrderDate
ORDER BY "Subtotal" DESC LIMIT 10;

--Query 4
SELECT I.CategoryName AS "CategoryName", rpad((to_char((SUM(P.UnitPriceOfProduct * S.OrderQuantity * (1 - S.OrderDiscount))), '999,999.99')), 
CHAR_LENGTH(to_char((SUM(P.UnitPriceOfProduct * S.OrderQuantity * (1 - S.OrderDiscount))), '999,999.99')) + 2, ' €') AS "Gross Profit"
FROM Inventory AS I JOIN Product AS P ON I.InventoryID = P.InventoryID JOIN Sends AS S ON S.ProductID = P.ProductID 
JOIN OrderShip AS O ON O.OrderShipID = S.OrderShipID
WHERE EXTRACT(YEAR FROM O.OrderDate) = 1998
GROUP BY I.CategoryName
ORDER BY "Gross Profit" DESC;

--Query 5
SELECT O.OrderDate AS "OrderDate", (SELECT DISTINCT COUNT(O2.OrderFreight) FROM OrderShip AS O2 WHERE O.OrderDate = O2.OrderDate) AS "ordersdelivered"
FROM OrderShip AS O JOIN Sends AS S ON S.OrderShipID = O.OrderShipID
GROUP BY O.OrderDate
HAVING SUM (S.OrderQuantity) > 320
ORDER BY "ordersdelivered" DESC, O.OrderDate ASC LIMIT 3;

--Query 6
SELECT C.CompanyName AS "CompanyName", CAST(SUM(SE.OrderQuantity)AS DECIMAL)*100/
(SELECT SUM(OrderQuantity) FROM Sends) AS p
FROM Company AS C JOIN Shipper AS S ON S.ShipperID = C.CompanyID JOIN Sends AS SE ON SE.ShipperID = S.ShipperID
JOIN OrderShip AS O ON O.OrderShipID = SE.OrderShipID
GROUP BY C.CompanyName
ORDER BY p DESC;

--Query 7
SELECT 'French' AS Language, COUNT(E.Notes) AS n
FROM Employee AS E
WHERE Notes LIKE '%French%'
UNION
SELECT 'Spanish' AS Language, COUNT(E.Notes) AS n
FROM Employee AS E
WHERE Notes LIKE '%Spanish%'
UNION
SELECT 'Japanese' AS Language, COUNT(E.Notes) AS n
FROM Employee AS E
WHERE Notes LIKE '%Japanese%'
UNION
SELECT 'Portuguese' AS Language, COUNT(E.Notes) AS n
FROM Employee AS E
WHERE Notes LIKE '%Portuguese%'
UNION
SELECT 'German' AS Language, COUNT(E.Notes) AS n
FROM Employee AS E
WHERE Notes LIKE '%German%'
UNION
SELECT 'Italian' AS Language, COUNT(E.Notes) AS n
FROM Employee AS E
WHERE Notes LIKE '%Italian%'
ORDER BY n DESC;

--Query 8
SELECT COUNT(S.OrderShipID) AS n, P.ProductID AS "ProductID", P.ProductName AS "ProductName"
FROM Product AS P JOIN Sends AS S ON S.ProductID = P.ProductID
WHERE S.OrderShipID IN (SELECT S2.OrderShipID FROM Sends AS S2 GROUP BY S2.OrderShipID HAVING COUNT(S2.ProductID) > 1)
GROUP BY P.ProductID, P.ProductName
ORDER BY n DESC LIMIT 1;

--Query 9
SELECT S5.OrderShipID AS "OrderID", S5.ProductID AS "ProductID"
FROM Sends AS S5
WHERE S5.OrderShipID IN (SELECT S4.OrderShipID
FROM Sends AS S4
WHERE S4.OrderShipID IN 
(SELECT S3.OrderShipID FROM Sends AS S3
WHERE S3.ProductID = (SELECT P.ProductID
FROM Product AS P JOIN Sends AS S ON S.ProductID = P.ProductID
WHERE S.OrderShipID IN (SELECT S2.OrderShipID FROM Sends AS S2 GROUP BY S2.OrderShipID HAVING COUNT(S2.ProductID) > 1)
GROUP BY P.ProductID, P.ProductName
ORDER BY COUNT(S.OrderShipID) DESC LIMIT 1))
GROUP BY S4.OrderShipID
HAVING COUNT (S4.ProductID) > 1)
ORDER BY S5.OrderShipID ASC;

--Query 10
--Trobar el costumer que mes diners ha gastat
SELECT P.FirstName AS Name, P.LastName AS LastName, SUM(S.OrderUnitPrice * S.OrderQuantity) AS "Total bought" FROM Person AS P 
JOIN Sends AS S ON S.CustomerID = P.PersonID
GROUP BY PersonID 
ORDER BY "Total bought" DESC LIMIT 1;