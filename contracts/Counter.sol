// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; //we tell which version we use so that compiler can tell from our smart contract

contract Counter {
    uint public count = 0;  //variable 1,2,3..unit=>unsigned integer

//write function
    function incrementCount() public  {
        count = count + 1;  //it updates the value
    }
}