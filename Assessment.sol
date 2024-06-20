// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MyToken {

    // Public variables
    string public Name;
    string public Abbrivation;
    uint public TotalSupply;
    
    // Mapping to store balances
    mapping(address => uint) public balance;

    // Constructor to initialize the token
    constructor(string memory _name, string memory _abbrivation, uint _initialSupply) {
        Name = _name;
        Abbrivation = _abbrivation;
        TotalSupply = _initialSupply;
        balance[msg.sender] = _initialSupply;
    }

    // Mint function to create some new tokens
    function mint(address add, uint amount) public {
        require(amount > 0, "Mint amount must be greater than zero");
        
        uint oldTotalSupply = TotalSupply;
        TotalSupply += amount;
        balance[add] += amount;

        // Ensure total supply is correctly updated
        assert(TotalSupply == oldTotalSupply + amount);
    }

    // Burn function to destroy tokens
    function burn(address add, uint amount) public {
        require(amount > 0, "Burn amount must be greater than zero");
        require(balance[add] >= amount, "Insufficient balance to burn");

        uint oldTotalSupply = TotalSupply;
        uint oldBalance = balance[add];

        TotalSupply -= amount;
        balance[add] -= amount;

        // Ensure total supply and balance are correctly updated
        assert(TotalSupply == oldTotalSupply - amount);
        assert(balance[add] == oldBalance - amount);

        if (balance[add] < amount) {
            revert("Burn operation failed due to insufficient balance");
        }
    }
}
