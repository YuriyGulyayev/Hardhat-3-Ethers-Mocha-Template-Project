// SPDX-License-Identifier: MIT
pragma solidity =0.8.29;

contract MaliciousContract {
   function maliciousMethod1() external {
      // This can do something malicious, like a reentrancy attack.
   }
}
