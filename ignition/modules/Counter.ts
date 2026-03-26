// import type {ContractOptions,} from "@nomicfoundation/ignition-core";
import {buildModule,} from "@nomicfoundation/hardhat-ignition/modules";
import * as IgnitionHelpers from "../src/IgnitionHelpers.ts";

// By default, transaction requests are sent on behalf of the signer at the index of zero.
export default buildModule(
   "CounterModule",
   (ignitionModuleBuilder_) => {
      IgnitionHelpers.warnIfDeploymentStateExistsOnce();

      /** Comment-202603184 applies. */
      const defaultX_ = 1234n;

      const counter_ = ignitionModuleBuilder_.contract("Counter", [defaultX_,]);
      const by_ = 5n;
      ignitionModuleBuilder_.call(counter_, "incBy", [by_,]);
      return {
         counter: counter_,
      };
   }
);
