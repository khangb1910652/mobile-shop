# User Guide and Source Code Installation Instructions

## Step 1: Install Node.js
1. Visit the official Node.js website at [https://nodejs.org](https://nodejs.org).
2. Download the Node.js version suitable for your operating system (usually the LTS - Long-Term Support version).
3. Open the downloaded installation file and follow the on-screen installation instructions.
4. Complete the Node.js installation process.

## Step 2: Install the Database
1. Start MySQL on the XAMPP application or another application that supports MySQL.
2. Create a database named "nlcs."
3. Import the database using the SQL file provided in the project.

## Step 3: Install Yarn
1. Open a terminal or command prompt on the server.
2. Run the command `$ npm install --global yarn` to install the Yarn package manager.

## Step 4: Install and Start the Server
1. Open a terminal or command prompt on the server.
2. Navigate to the directory containing the server project code.
3. Run the command `$ yarn` to install project dependencies.
4. After the installation is complete, run the command `$ yarn start` to start the server.

## Step 5: Install and Run the User Interface (UI)
1. Open a terminal or command prompt on your computer.
2. Navigate to the directory containing the user interface project code.
3. Run the command `$ yarn` to install project dependencies.
4. After the installation is complete, run the command `$ yarn start` to launch the user interface.
