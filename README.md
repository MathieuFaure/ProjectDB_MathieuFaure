# ProjectDB_MathieuFaure

## The prompt I used:

You work in the field of international motorsport championship management. Your organization is involved in the domain of Formula 1 championship organization and race management. It is an organization such as the governing bodies that manage competitions like Formula 1 and work with teams such as Scuderia Ferrari. Your organization is responsible for collecting data about races, teams, drivers and results. Take inspiration from the following references: “Public information about Formula 1 race weekends and scoring systems” (https://www.formula1.com/en/latest/article/the-beginners-guide-to-the-formula-1-weekend.5RFZzGXNhEi9AEuMXwo987) , “Team and driver statistics available on official championship websites” (https://www.formula1.com/en/teams) .
Your organization wants to apply MERISE to design an information system. You are responsible for the analysis part, i.e., gathering the company's requirements. It has called on a computer engineering student to carry out this project, and you must provide him with the necessary information so that he can then apply the following steps of database design and development himself.
First, establish the data business rules for your organization in the form of a bulleted list. It must correspond to the information provided by someone who knows how the company works, but not how an information system is built.
Next, based on these rules, provide a raw data dictionary with the following columns, grouped in a table: meaning of the data, type, size in number of characters or digits. There should be between 25 and 35 data items. It is used to provide additional information about each data item (size and type) but without any assumptions about how the data will be modeled later.
Provide the business rules and the data dictionary.

## Business Rules:

The organization manages an international single-seater championship such as Formula 1.
The championship is divided into seasons (usually one per year).
Each season contains several race events called Grands Prix.
Each Grand Prix takes place at one circuit and on scheduled dates.
A circuit has a name, a location (country, city), a length and a number of laps for the race.
Each Grand Prix belongs to exactly one season.
A season has one official calendar listing all its Grands Prix.
Teams participate in the championship for a full season.
A team has a name, a nationality and a unique identifier.
A team registers two main drivers for a season.
A driver has a full name, date of birth, nationality and a permanent racing number.
A driver may change teams between seasons.
For each Grand Prix, drivers are entered by their team.
Each Grand Prix weekend includes sessions (practice sessions, qualifying, race).
Each session has a date, a start time and a type.
The race session produces the official results for the Grand Prix.
Each race result links one driver to one Grand Prix.
A finishing position is recorded for each classified driver.
Points are awarded based on finishing position according to an official scoring system.
The scoring system may change from season to season.
Drivers and teams accumulate points over a season.
A driver championship ranking is established per season.
A constructor (team) championship ranking is established per season.
A driver may record fastest lap in a race.
Fastest lap may grant additional points if regulations allow it.
Not all drivers who start a race are necessarily classified as finishers.
A driver can be marked as DNF (did not finish) or DSQ (disqualified).
Weather conditions are recorded for each race.
Incidents and penalties may be recorded for drivers during a race.
A penalty can affect time or finishing position.
The organization publishes official results and standings after validation.
Historical data from past seasons must be preserved and accessible.
External stakeholders (media, teams, public) consult published statistics.
Teams such as Scuderia Ferrari are treated like any other team in the system.

## Data dictionnary:

| Meaning of the data                 | Type         | Size                 |
| ----------------------------------- | ------------ | -------------------- |
| Season year                         | Numeric      | 4 digits             |
| Season start date                   | Date         | 10 char              |
| Season end date                     | Date         | 10 char              |
| Grand Prix name                     | Alphanumeric | 60 char              |
| Grand Prix code                     | Alphanumeric | 10 char              |
| Grand Prix date                     | Date         | 10 char              |
| Circuit name                        | Alphanumeric | 60 char              |
| Circuit city                        | Alphanumeric | 40 char              |
| Circuit country                     | Alphanumeric | 40 char              |
| Circuit length (km)                 | Decimal      | 5 digits, 2 decimals |
| Number of race laps                 | Numeric      | 3 digits             |
| Team name                           | Alphanumeric | 60 char              |
| Team nationality                    | Alphanumeric | 40 char              |
| Team identifier                     | Alphanumeric | 10 char              |
| Driver full name                    | Alphanumeric | 60 char              |
| Driver date of birth                | Date         | 10 char              |
| Driver nationality                  | Alphanumeric | 40 char              |
| Driver number                       | Numeric      | 2 digits             |
| Session type                        | Alphanumeric | 20 char              |
| Session date                        | Date         | 10 char              |
| Session start time                  | Time         | 5 char               |
| Finishing position                  | Numeric      | 2 digits             |
| Grid position                       | Numeric      | 2 digits             |
| Points awarded                      | Numeric      | 2 digits             |
| Fastest lap time                    | Time         | 12 char              |
| Fastest lap flag                    | Boolean      | 1 char               |
| Classification status (FIN/DNF/DSQ) | Alphanumeric | 3 char               |
| Weather condition                   | Alphanumeric | 30 char              |
| Penalty type                        | Alphanumeric | 30 char              |
| Penalty time (seconds)              | Numeric      | 4 digits             |
| Driver season points total          | Numeric      | 4 digits             |
| Team season points total            | Numeric      | 4 digits             |
