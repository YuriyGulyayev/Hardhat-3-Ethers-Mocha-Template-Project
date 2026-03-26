// #region Imports

import {expect,} from "chai";
import {describe, before, after, it,} from "mocha";
import type {NetworkConnection,} from "hardhat/types";
import type {HardhatEthersSigner,} from "@nomicfoundation/hardhat-ethers/types";
import hre from "hardhat";
import * as EthersHelpers from "../../src/EthersHelpers.ts";
import * as ContractDeploymentHelpers from "../../ignition/src/ContractDeploymentHelpers.ts";

// #endregion
// #region `describe`

describe("Counter", () => {
   // #region Data

   /** Comment-202603184 applies. */
   const defaultX_ = 1234n;

   let networkConnection_: NetworkConnection | undefined;
   let signers_: HardhatEthersSigner[];

   // #endregion
   // #region `deployContracts_`

   const deployContracts_ =
      async () => {
         return ContractDeploymentHelpers.deployProductionContracts( networkConnection_ ! );
      };

   // #endregion
   // #region `before`

   before(
      async () => {
         networkConnection_ = await hre.network.connect();
         signers_ = await networkConnection_.ethers.getSigners();
         // console.info("%s", `202603193 ${signers_.length}");
      }
   );

   // #endregion
   // #region `after`

   after(
      async () => {
         const networkConnectionCopy_ = networkConnection_;
         if(networkConnectionCopy_ != undefined) {
            networkConnection_ = undefined;
            await networkConnectionCopy_.close();
         }
      }
   );

   // #endregion
   // #region `it`

   it("Shall emit the `Increment` event when calling `inc`.", async () => {
      // const counter_ = await ( networkConnection_ ! ).ethers.deployContract("Counter", [defaultX_,], signers_[1]);
      // await counter_.waitForDeployment();
      const contracts_ = await ( networkConnection_ ! ).networkHelpers.loadFixture(deployContracts_);

      // Issue. This Hardhat generated code fails when the network is configured for interval mining,
      // apparently because Hardhat forgets to wait for the transaction to get mined.
      // See discussions at:
      //    https://github.com/NomicFoundation/hardhat/issues/3203
      //    https://github.com/NomicFoundation/hardhat/issues/4242
      // It appears that they aren't going to fix this issue.
      // So I have refactored this to wait.
      // await expect(counter_.inc()).emit(counter_, "Increment").withArgs(1n);
      await expect(await EthersHelpers.waitForTransactionReceipt(contracts_.counter.connect(signers_[2]).inc())).emit(contracts_.counter, "Increment").withArgs(1n);
   });

   // #endregion
   // #region `it`

   it("The sum of the `Increment` events shall match the current value minus the initial value.", async () => {
      const by_ = 5n;
      const contracts_ = await ( networkConnection_ ! ).networkHelpers.loadFixture(deployContracts_);

      // Issue. In case we are running against the in-process network, without this forced block creation,
      // near Comment-202603151, we would query events occurred before this test.
      await ( networkConnection_ ! ).provider.request({method: "evm_mine",});

      const initialBlockNumber_ = await ( networkConnection_ ! ).ethers.provider.getBlockNumber();

      // Running a series of increments.
      for( let incrementCounter_ = 1; incrementCounter_ <= 3; ++ incrementCounter_ ) {
         // const dateTimeStamp1_ = Date.now();
         await EthersHelpers.waitForTransactionReceipt(contracts_.counter.connect(signers_[2]).incBy(incrementCounter_));
         // console.log("%d", Date.now() - dateTimeStamp1_);
      }

      // [Comment-202603151/]
      const events_ =
         await contracts_.counter.queryFilter(contracts_.counter.filters.Increment(), initialBlockNumber_, "latest");

      // Checking that the aggregated events match the current value.
      let total_ = 0n;
      for(const event_ of events_) {
         total_ += event_.args.by;
      }
      expect(await contracts_.counter.x() - (defaultX_ + by_)).equal(total_);
   });

   // #endregion
   // #region `it`

   // In case we are running against an out-of-process network, this last test is needed to reset its state.
   // Otherwise, if you run the tests again, they would not necessarily succeed.
   it("Blockchain state reset.", async () => {
      // const contracts_ =
      await ( networkConnection_ ! ).networkHelpers.loadFixture(deployContracts_);
   });

   // #endregion
});

// #endregion
