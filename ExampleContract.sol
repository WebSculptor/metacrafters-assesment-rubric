// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleContract {
    address public owner;
    uint256 public value;
    
    constructor() {
        owner = msg.sender;
    }
    
    function setValue(uint256 _newValue) public {
        // only owner can set the value
        require(msg.sender == owner, "Only the owner can set the value");
        
        // make sure the new value is not 0
        assert(_newValue != 0);
        
        // check if the new value is greater than the current value
        require(_newValue > value, "New value must be greater than the current value");
        
        // the update the value to the new value
        value = _newValue;
    }
    
    function withdraw() public {
        // only owner can withdraw
        require(msg.sender == owner, "Only the owner can withdraw");
        
        // check if the contract has enough balance to withdraw
        require(address(this).balance > 0, "Contract balance is zero");
        
        // send the balance to the owner
        bool success = payable(owner).send(address(this).balance);
        
        // ff sending fails, revert and return the funds to the contract
        if (!success) {
            revert("Failed to send funds");
        }
    }
}
