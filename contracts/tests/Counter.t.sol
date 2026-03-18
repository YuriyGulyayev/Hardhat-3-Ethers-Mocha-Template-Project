// SPDX-License-Identifier: MIT
pragma solidity =0.8.29;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../production/Counter.sol";

// Solidity tests are compatible with foundry, so they
// use the same syntax and offer the same functionality.

contract CounterTest is Test {
   uint256 constant private _DEFAULT_X = 1234;
   Counter immutable private _counter;

   // function setUp() public {
   constructor() {
      _counter = new Counter(_DEFAULT_X);
   }

   // solhint-disable-next-line func-name-mixedcase
   function test_InitialValue() public view {
      // solhint-disable-next-line gas-custom-errors
      require(_counter.x() == _DEFAULT_X, "Invalid initial value.");
   }

   // solhint-disable-next-line func-name-mixedcase
   function testFuzz_Inc(uint8 n_) public {
      for( uint8 counter_ = 0; counter_ < n_; ++ counter_ ) {
         _counter.inc();
      }
      // solhint-disable-next-line gas-custom-errors, reason-string, gas-small-strings
      require(_counter.x() == _DEFAULT_X + n_, "Invalid value after calling `inc` `n_` times.");
   }

   // solhint-disable-next-line func-name-mixedcase
   function test_IncByZero() public {
      vm.expectRevert();
      _counter.incBy(0);
   }
}
