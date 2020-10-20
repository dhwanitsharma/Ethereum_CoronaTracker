# Ethereum Corona Tracker

This project is Blockchain based project where I have created a Corona Tracker which can trace a person to the location he has visited during the pandemic. The idea aroung the app is that whenever a person visits a particular area/address in a sector, we will log is checkin in the blockchain with sector and the current zone defined by the government for the sector.

For example, I visit address A which is in the red zone of the city, it will be logged into the blockchain. Now whenever I try to checkin in any other location, they will get a list of places where I have checked-in with the zone status. If I have been to a red zone and checking into a greez zone location, they can take the required precautions prescribed by the government.

I have implemented the Project on the personal Ethereum blockchain using Truffle FrameWork and Ganache. I have create a smart contract on solidity to handle the transactions on blockchain. I have also used Metamask Chrome extention to integrate the account to perform the transactions on the blockchain involving Gas Price. The Gas price will only be required during the check-in process, we can inquire data from the blockchain free of cost. 

### Application Flow
The front page will have to tabs,"Create Check-In" where i can create a new check-in and "Get Check-ins" tab which inquire all the previous checkins

![Optional Text](../master/projImages/coronatracker1.png)


On "Create Check-in" tab we can add the required information about the person as below:

![Optional Text](../master/projImages/coronatracker2.png)

To complete the checkin we will have to pay a GAS PRICE as we need to make the changes on the blockchain.

![Optional Text](../master/projImages/coronatracker3.png)

We can inquire all the checkins of the person from "Get Check-ins" tab.

![Optional Text](../master/projImages/coronatracker4.png)

### Tech Stack
Solidity

JavaScript

HTML5

### Tools Used
Ganache Cli

Truffle Suite

MetaMask Chrome Plugin

### Additional Libraries
Chai Assertion Library

Bootstrap

### Server
lite-server
