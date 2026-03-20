## Inlamning2 skapad av Johanna Swann YH25

Jag har skapat en databas för en liten bokhandel som lagrar information i flera tabeller och visar hur dessa hänger ihop med hjälp av primärnycklar (PK)
och främmande nycklar (FK). 

## Databasen innehåller tabellerna
* Kunder - innehåller information om kunder
* Böcker - innehåller information om böcker
* Beställningar - kopplar kunder till beställningar
* Orderrader - innehåller vilka böcker som ingår i en beställning
* Kundlogg - loggar automatiskt nya kunder med hjälp av en trigger

## Databasen innehåller följande relationer
* En kund kan göra flera beställningar
* En beställning kan innehålla flera orderrader
* En bok kan finnas på flera orderrader

## Bild på mitt ER-diagram
<img width="665" height="541" alt="er-diagram" src="https://github.com/johannaswann/Inlamning2/blob/main/er-diagram.png?raw=true" />
