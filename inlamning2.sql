

-- Inlamning1 Johanna Swann YH25

-- Skapar databasen för en liten bokhandel
CREATE DATABASE Bokhandel;
USE Bokhandel; -- Använda databasen
 
 -- Skapar kundtabellen 
CREATE TABLE Kunder (
KundID INT AUTO_INCREMENT PRIMARY KEY, -- Varje kund får ett unikt KundID 
Namn VARCHAR(100) NOT NULL, -- Varje kund måste ha ett namn och kan inte lämnas tomt
Email VARCHAR(255) UNIQUE NOT NULL, -- Måste finnas en unik email för varje kund
Telefon VARCHAR(50), -- Telefon är frivilligt att registrera
Adress VARCHAR(255)
);

-- Skapar tabellen för böcker
CREATE TABLE Bocker (
BokID INT AUTO_INCREMENT PRIMARY KEY,
Titel VARCHAR(255) NOT NULL,
ISBN VARCHAR(50) UNIQUE NOT NULL,
Forfattare VARCHAR(255) NOT NULL,
Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0), -- Pris måste anges och vara större än 0
Lagerstatus INT NOT NULL
);

-- Skapar tabellen för beställningar
CREATE TABLE Bestallningar (
OrderID INT AUTO_INCREMENT PRIMARY KEY,
KundID INT NOT NULL,    -- En beställning måste tillhöra en kund
Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Tilldelas datum och tid automatiskt
Totalbelopp DECIMAL(10,2) NOT NULL,
FOREIGN KEY (KundID) REFERENCES Kunder (KundID) -- Lånar PK från Kunder (KundID)
);

-- Skapar tabellen för orderrader
CREATE TABLE Orderrader (
Orderrader INT AUTO_INCREMENT PRIMARY KEY,
BokID INT NOT NULL,
OrderID INT NOT NULL, 
Antal INT NOT NULL CHECK (Antal > 0),
Styckepris DECIMAL(10,2) NOT NULL,
FOREIGN KEY (BokID) REFERENCES Bocker (BokID), -- Lånar PK från Böcker (BokID)
FOREIGN KEY (OrderID) REFERENCES Bestallningar (OrderID) -- Lånar PK Beställningar (OrderID)
);

-- Infogar data i kunder
INSERT INTO Kunder (Namn, Email) VALUES
('Jon Snow', 'jon@email.com'),
('Arya Stark', 'arya@email.com'),
('Tyrion Lannister', 'tyrion@email.com');

-- Infogar data i böcker
INSERT INTO Bocker (Titel, BokID, ISBN, Forfattare, Pris, Lagerstatus) VALUES
('A Song of Ice and Fire', '5585', '95-646-75-87', 'Sam Thompson', 399.00, 8),
('A Dance with Dragons', '5586', '45-646-35-86', 'Adam Holmshaw', 199.00, 10),
('A Clash of Kings', '5587', '25-456-35-85', 'Rosie Murphy', 299.00, 6);

-- Infogar data i beställningar
INSERT INTO Bestallningar (KundID, Datum, Totalbelopp) VALUE
(1, '2024-10-15', 399.00), -- Jon koper 1 bocker
(2, '2024-10-02', 598.00), -- Arya koper 2 bocker
(3, '2024-09-28', 299.00); -- Tyrion koper 1 bok

-- Infogar data i orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Styckepris) VALUES
(1, '5585', 1, 399.00);

-- Infogar data i orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Styckepris) VALUES
(2, '5585', 1, 399.00),
(2, '5586', 1, 199.00);

-- Infogar data i orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Styckepris) VALUES
(3, '5587', 1, 299.00);

-- Hämtar all data från tabellerna Böcker, Kunder, Beställningar och Orderrader
SELECT * FROM Bocker;
SELECT * FROM Kunder;
SELECT * FROM Bestallningar;
SELECT * FROM Orderrader;


-- Inlamning2 Johanna Swann YH25

-- Hämtar alla kunder med namnet Jon Snow
SELECT * FROM Kunder WHERE Namn = 'Jon Snow';

-- Hämtar kunder där namnet innehåller "ty" eller email börjar med "ty@email.com
SELECT * FROM Kunder WHERE Namn LIKE '%ty%' OR Email LIKE 'ty@email.com%';


SELECT * FROM Bocker ORDER BY Pris ASC; -- Sortera böcker från lägsta till högsta pris
SELECT * FROM Bocker ORDER BY Pris DESC; -- Sortera böcker från högsta till lägsta pris


-- Uppdaterar email för kunden med KundID 1
UPDATE Kunder SET Email = 'jonsnow@email.com' WHERE KundID = 1;
SELECT * FROM Kunder WHERE KundID = 1; -- Hämtar kunden med KundID 1 för att se om emailen har uppdaterats


-- Börjar en transaktion
START TRANSACTION; 
UPDATE Kunder SET Email = 'newarya@email.com' WHERE KundID = 2; -- Uppdaterar email för kunden med KundID 2
SELECT * FROM Kunder WHERE KundID = 2; -- Visar kunden med KundID 2 för att kontrollera ändringen
ROLLBACK; -- Ångrar ändringen i transaktionen
SELECT * FROM Kunder WHERE KundID = 2; -- Kontrollerar att emailen återställts efter rollback


-- Skapar en inner join som kopplar kunder med deras beställningar 
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder 
INNER JOIN Bestallningar 
ON Kunder.KundID = Bestallningar.KundID;

-- Skapar en left join som visar alla kunder och deras beställningar (även de utan beställningar)
SELECT Kunder.Namn, Bestallningar.OrderID FROM Kunder
LEFT JOIN Bestallningar
ON Kunder.KundID = Bestallningar.KundID;

-- Räknar antal beställningar per kund
SELECT KundID, COUNT(OrderID) AS AntalBestallningar
FROM Bestallningar GROUP BY KundID;

-- Hämtar kunder som har gjort fler än 2 beställningar
SELECT Kunder.Namn, COUNT(OrderID) As Antalbestallningar FROM Bestallningar 
INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID 
GROUP BY Kunder.Namn
HAVING COUNT(OrderID) > 2;


-- Skapar ett index på email i tabellen kunder
CREATE INDEX idx_email 
ON Kunder(Email);
SHOW INDEX FROM Kunder; -- Kontrollerar att indexet på email har skapats


-- Lägger till en constraint som säkerställer att priset är över 0
ALTER TABLE Bocker 
ADD CONSTRAINT check_pris 
CHECK (Pris > 0);
-- Testar constrainten genom att lägga till en bok med pris 0
INSERT INTO Bocker (Titel, ISBN, Forfattare, Pris, Lagerstatus) 
VALUES ('Gratisbok', '96-546-55-88', 'Sarah Smith', 0, 2);


-- Skapar en trigger som minskar lagersaldo i böcker när en orderrad läggs till
DELIMITER $$

CREATE TRIGGER minska_lager
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
    UPDATE Bocker 
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE BokID = NEW.BokID;
END $$

DELIMITER ;

-- Lägger till en orderrad för att testa triggern
INSERT INTO Orderrader (BokID, OrderID, Antal, Styckepris) 
VALUES (5585, 1, 1, 399.99);  -- Beställer 1 bok 

-- Hämtar boken för att se om lagerstatusen har minskat
SELECT * FROM Bocker 
WHERE BokID = 5585;


-- Skapar en tabell som loggar nya kunder
CREATE TABLE Kundlogg (
    LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT,
    Registreringsdatum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);

-- Skapar en trigger som loggar när en ny kund registreras i tabellen kundlogg
DELIMITER $$

CREATE TRIGGER logga_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
    INSERT INTO Kundlogg (KundID)
    VALUES (NEW.KundID);
END $$

DELIMITER ;
 
 -- Lägger till en ny kund för att testa triggern
INSERT INTO Kunder (Namn, Email)
VALUES ('Sansa Stark', 'sansa@email.com');

SELECT * FROM Kundlogg; -- Hämtar kundloggen för att kontrollera att triggern fungerar


