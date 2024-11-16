// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Demonstrates the use of inheritance, access control, and factory pattern 
// Factory pattern: A contract that creates instances of other contracts

// This contract handles ownership logic and restricts access to specific functions
contract Ownable {
    address owner; // Address of the contract owner

    // Modifier to restrict access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "must be owner");
        _; // Continue execution of the function
    }

    // Constructor to set the deployer of the contract as the owner
    constructor() {
        owner = msg.sender; // Assign the deployer as the owner
    }
}

// This contract stores a "secret" and allows retrieval of it
contract SecretVault {
    string secret; // Private storage for the secret

    // Constructor to initialize the contract with a secret
    constructor(string memory _secret) {
        secret = _secret; // Store the secret
    }

    // Function to retrieve the secret (read-only)
    function getSecret() public view returns (string memory) {
        return secret; // Return the stored secret
    }
}

// Main contract that inherits from the `Ownable` contract
contract My_Contract is Ownable {
    address secretVault; // Address of the SecretVault contract created by this contract

    // Constructor to initialize the contract and create a new SecretVault
    constructor(string memory _secret) {
        // Create a new instance of SecretVault and store its address
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault); // Store the address of the SecretVault instance

        super; // Call the parent constructor (optional as Solidity does this implicitly)
    }

    // Function restricted to the owner to retrieve the secret from the SecretVault
    function getSecret() public view onlyOwner returns (string memory) {
        // Interact with the SecretVault contract to fetch the secret
        return SecretVault(secretVault).getSecret();
    }
}
