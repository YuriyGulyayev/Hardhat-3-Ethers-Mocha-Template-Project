import type {ContractOptions} from "@nomicfoundation/ignition-core";
import {buildModule} from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule(
   "CounterModule",
   (ignitionModuleBuilder_) => {
      const deployerAccountIndex_ = 1;
      const contractOptions_: ContractOptions = {from: ignitionModuleBuilder_.getAccount(deployerAccountIndex_),};
      const defaultX_ = 1234n;
      const counter_ =
         ignitionModuleBuilder_.contract("Counter", [defaultX_,], contractOptions_);
      const by_ = 5n;
      ignitionModuleBuilder_.call(counter_, "incBy", [by_,], contractOptions_);
      return {
         counter: counter_,
      };
   }
);
