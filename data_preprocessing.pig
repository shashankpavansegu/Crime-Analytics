--Chicago

A = LOAD 'chicago.csv' USING PigStorage(',') AS (Identifier, CaseNumber, Date, Block, IUCR, PrimaryType, Description, Location, Arrest, Domestic, Beat, District, Ward, Community, FBICode, XCoordinate, YCoordinate, Year, Updated, Latitude, Longitude, Location1);

B = FOREACH A GENERATE Identifier, PrimaryType, Year, Ward;

C = FILTER B BY Identifier IS NOT NULL AND PrimaryType IS NOT NULL AND Year IS NOT NULL AND Ward IS NOT NULL;

D = GROUP C BY Identifier;

REMOVE_DUPLICATES = FOREACH D { CAS = LIMIT C 1; GENERATE CAS;}

E = FOREACH REMOVE_DUPLICATES GENERATE FLATTEN($0);

F = LOAD 'Chicago_weights.txt' AS (PrimaryType, weight);

G = JOIN E BY PrimaryType, F BY PrimaryType;

H = FOREACH G GENERATE Identifier, $1, Ward, Year, weight;

STORE H INTO 'projectChicago';

--Detroit

A = LOAD 'detroit.csv' USING PigStorage(',') AS (rownumber, caseid, crimeid, crnumber, address, category, offense, stateoffense, date, hour, sca, precinct, council, neighbourhood, censustrack, lon, lat, location);

B = FOREACH A GENERATE caseid, category, date, precinct;

C = FILTER B BY caseid IS NOT NULL AND category IS NOT NULL AND date IS NOT NULL AND precinct IS NOT NULL;

D = GROUP C BY caseid;

REMOVE_DUPLICATES = FOREACH D { CAS = LIMIT C 1; GENERATE CAS;}

E = FOREACH REMOVE_DUPLICATES GENERATE FLATTEN($0);

F = LOAD 'Detroit_weights.txt' AS (category, weight);

G = JOIN E BY category, F BY category;

H = FOREACH G GENERATE caseid, $1, date, precinct,  weight;

STORE H INTO 'projectDetroit';

--NYC

A = load 'NYC.csv' USING PigStorage(',') AS (OBJECTID, IDENTIFIER, OCCURENCEDATE, DAYOFWEEK, OCCURENCEMONTH, OCCURENCEDAY, OCCURENCEYEAR, OCCURENCEHOUR, COMPSTATMONTH, COMPSTATDAY, COMPSTATYEAR, OFFENSE, CLASSIFICATION, SECTOR, PRECINCT, BOROUGH, JURISDICTION, XCOORDINATE, YCOORDINATE, LOCATION);

B = FOREACH A GENERATE IDENTIFIER, OFFENSE, PRECINCT, OCCURENCEDATE, OCCURENCEHOUR;

C = FILTER B BY IDENTIFIER IS NOT NULL AND PRECINCT IS NOT NULL AND OFFENSE IS NOT NULL AND OCCURENCEDATE IS NOT NULL AND OCCURENCEHOUR IS NOT NULL;

D = GROUP C BY IDENTIFIER;

REMOVE_DUPLICATES = FOREACH D { CAS = LIMIT C 1; GENERATE CAS;}

E = FOREACH REMOVE_DUPLICATES GENERATE FLATTEN($0);

F = LOAD '/user/cloudera/projInput/weight_Chicago.txt' AS (OFFENSE, weight);

G = JOIN E BY OFFENSE, F BY OFFENSE;

H = FOREACH G GENERATE ID, $1, PRECINCT, DATE, weight;

STORE H INTO 'projectNYC';