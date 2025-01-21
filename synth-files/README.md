
# Makeathon data syntheszer

Follow these instructions to generate a db of your required complexity.

## Step 1 (Install the required softwares)
* sqlite3
* python3
* Synth
Synth is the tool we will be using to generate the db data from the schema files defined in the schema folder.

Install Synth using the following command in a linux or mac system
`curl -sSL https://getsynth.com/install | sudo sh`

or follow the instructions on this page
https://www.getsynth.com

## Step 2 (Define the db schema for Synth)
The DB schema is defined in the folder `schema` according the the Synth schema declaration language. Each json file represents a DB table with the name of the file. Inside each schema file there is a length parameter which can be used to tell Synth how many rows needs to be generated for that particular table.

**Adjust the schema and length parameters according to the requirements of the DB complexity**

## Step 3 (Synthesize data for the DB using Synth)
Open terminal in the synth-files directory and run the following command

`synth generate schema/ > output.json`

the output will be generated as a json file named `output.json`

## Step 4 (Create the DB file using sqlite3)
Run the following command from this directory to create the db

`sqlite3 makeathondb`

This command will take you to the sqlite terminal. 
There, run the create table queries defined in the file `sqlfiles/create_tale.sql`

**Make sure to update the create script if the Synth schema is updated. Otherwise it will create insertion errors when running the data insertion python script**

## Step 5 (Insert the synthetic data to the DB)
Run the init.py python script available in this directory.

It will,
* Insert the data into the `makeathondb` from `output.json`
* Run some predefined refinement queries to clean the synthesized data. (any new cleanup query can be added to the `db_data_insertion/constants.py` file)

**When all these steps are completed, the sqlite db file with the synthesized data will be available in this directory with the file name `makeathondb`. It then can be copied to use anywhere**


