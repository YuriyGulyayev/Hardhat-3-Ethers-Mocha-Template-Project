// #region Imports

// import {setTimeout} from "node:timers/promises";
import {expect} from "chai";
import {describe, before, after, it} from "mocha";
import type {EventLog} from "ethers";
import type {NetworkConnection} from "hardhat/types";
// import type {HardhatEthersSigner} from "@nomicfoundation/hardhat-ethers/types"
import hre from "hardhat";
import {Helpers} from "../../src/Helpers.ts";
import counterModule from "../../ignition/modules/Counter.ts";

// #endregion
// #region `describe`

describe("Counter", () => {
   // #region Data

   let networkConnection_: NetworkConnection | undefined;
   // let signers_: HardhatEthersSigner[];

   // #endregion
   // #region `before`

   before(
      async () => {
         networkConnection_ = await hre.network.connect();
         // signers_ = await networkConnection_.ethers.getSigners();
      }
   );

   // #endregion
   // #region `after`

   after(
      async () => {
         const networkConnectionCopy_ = networkConnection_;
         if(networkConnectionCopy_ != undefined) {
            networkConnection_ = undefined
            await networkConnectionCopy_.close();
         }
      }
   );

   // #endregion
   // #region `it`

   it("Shall emit the `Increment` event when calling `inc`.", async () => {
      // const defaultX_ = 1234n;
      //      
      // const counter_ = await ( networkConnection_ ! ).ethers.deployContract("Counter", [defaultX_,], signers_[1]);
      // await counter_.waitForDeployment();

      const contracts_ =
         await ( networkConnection_ ! ).networkHelpers.loadFixture(deployContracts_);

      // Issue. This fails when the network is configured for interval mining,
      // apparently because Hardhat forgets to wait for the transaction to get mined.
      // See discussions at:
      //    https://github.com/NomicFoundation/hardhat/issues/3203
      //    https://github.com/NomicFoundation/hardhat/issues/4242
      // It appears that they aren't going to fix this issue.
      // So I have refactored this to wait.
      // await expect(counter_.inc()).emit(counter_, "Increment").withArgs(1n);
      await expect(await Helpers.waitForTransactionReceipt(contracts_.counter.inc())).emit(contracts_.counter, "Increment").withArgs(1n);
   });

   // #endregion
   // #region `it`

   it("The sum of the `Increment` events shall match the current value minus the initial value.", async () => {
      const defaultX_ = 1234n;
      const by_ = 5n;

      const contracts_ =
         await ( networkConnection_ ! ).networkHelpers.loadFixture(deployContracts_);

      // Issue. In case we are running against the in-process network, without this, near Comment-202603151
      // we would query events occurred before this test.
      await ( networkConnection_ ! ).provider.request({method: "evm_mine",});

      const initialBlockNumber_ = await ( networkConnection_ ! ).ethers.provider.getBlockNumber();

      // Running a series of increments.
      for( let incrementCounter_ = 1; incrementCounter_ <= 3; ++ incrementCounter_ ) {
         // const dateTimeStamp1_ = Date.now();
         await Helpers.waitForTransactionReceipt(contracts_.counter.incBy(incrementCounter_));
         // console.log("%d", Date.now() - dateTimeStamp1_);
      }

      // [Comment-202603151/]
      const events_ =
         await contracts_.counter.queryFilter(contracts_.counter.filters.Increment(), initialBlockNumber_, "latest") as EventLog[];

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
   // Otherwise our tests would not necessarily succeed next time,
   // provided you do not restart the out-of-process network and/or do not delete `ignition/deployments/chain-31337`.
   it("Blockchain state reset.", async () => {
      // const contracts_ =
         await ( networkConnection_ ! ).networkHelpers.loadFixture(deployContracts_);
   });

   // #endregion
   // #region `deployContracts_`

   const deployContracts_ =
      async () => {
         const contracts_ =
            await ( networkConnection_ ! ).ignition.deploy(counterModule);
         return contracts_;
      }

   // #endregion
});

// #endregion
