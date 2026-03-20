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

## Reflektion och analys
Jag designade min databasen med hjälp av MySQL och valde att dela upp den i separata tabeller för kunder, böcker, beställningar och orderrader för att göra strukturen tydligare och för att undvika duplicerad data. Med hjälp av primärnycklar (PK) och främmande nycklar (FK) kopplas tabellerna ihop så att datan hör ihop. 

Till exempel lagras kundens information bara i tabellen kunder och kopplas till beställningar med hjälp av KundID. En beställning kan innehålla flera orderrader, och varje orderrad är kopplad till en bok, vilket gör det enkelt att se vad en kund har beställt. 

Jag har också skapat en kundlogg som automatiskt sparar information när en ny kund läggs till med hjälp av en trigger. Detta gör databasen mer automatiserad och gör att man slipper lägga in information manuellt.  

Om min databasen skulle hantera 100 000 kunder istället för 10 skulle jag fokusera mer på prestanda. Jag hade till exempel lagt till fler index, som på KundID och BokID, så att sökningar kan köras snabbare och mer effektivt. Det hade också varit viktigt att göra regelbundna backups av databasen, så att ingen data försvinner om något går fel. Man skulle också kunna förbättra databasen genom att använda index på viktiga kolumner och skriva enklare och tydligare frågor för att spara tid. Slutligen skulle jag säga att de är viktigt att databasen är tydligt struktuerad och uppbyggd så att den är enkel att förstå och använda.   



