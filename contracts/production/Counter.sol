// SPDX-License-Identifier: MIT
pragma solidity =0.8.29;

contract Counter {
   uint256 public x;

   // solhint-disable-next-line gas-indexed-events
   event Increment(uint256 by);

   error ZeroBy();

   constructor(uint256 x_) {
      x = x_;
   }

   function inc() public {
      ++ x;
      emit Increment(1);
   }

   function incBy(uint256 by_) public {
      // require(by_ > 0, "incBy: increment shall be positive.");
      if( ! (by_ > 0) ) {
         revert ZeroBy();
      }
      x += by_;
      emit Increment(by_);
   }

   /// @notice This is to make contract bytecode unique and therefore unknown to the blockchain.
   /// Because otherwise deployment to a live blockchain would fail.
   function dummyFunction() external pure returns(uint256) {
      return 202603152;
   }
}
