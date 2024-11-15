//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    // Enum to represent the status of the room: Vacant or Occupied
    enum Statuses {
        Vacant, // Room is available for booking
        Occupied // Room is currently booked
    }

    Statuses public currentStatus; // Public variable to track the current status of the room

    // Event to log room booking details
    event Occupy(address _occupant, uint _value);

    // Address of the contract owner, marked as payable to receive Ether
    address payable public owner;

    // Constructor to initialize the contract
    constructor() {
        owner = payable(msg.sender); // Setting the deployer as the contract owner
        currentStatus = Statuses.Vacant; // Initially, the room is vacant
    }

    // Modifier to ensure the room is vacant before proceeding
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied");
        _;
    }

    // Modifier to ensure the required payment amount is met
    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided.");
        _;
    }

    / Function to book the room
    function book() public payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied; // Mark the room as occupied

        // Transfer the Ether to the owner of the contract
        (bool sent, ) = owner.call{value: msg.value}(""); // Safe method to transfer Ether
        require(sent, "Failed to send Ether"); // Ensures the transfer was successful

        // Emit an event with the occupant's address and the value sent
        emit Occupy(msg.sender, msg.value);
    }
 
}