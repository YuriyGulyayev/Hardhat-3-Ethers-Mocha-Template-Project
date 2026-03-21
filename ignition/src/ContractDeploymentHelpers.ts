// #region Imports

import type {NetworkConnection} from "hardhat/types";
import type {Counter} from "../../types/ethers-contracts/index.ts";
import counterModule from "../modules/Counter.ts";

// #endregion
// #region `ContractDeploymentHelpers`

export class ContractDeploymentHelpers {
   // #region `deployProductionContracts`

   public static async deployProductionContracts(networkConnection_: NetworkConnection) {
      const contracts_ = await networkConnection_.ignition.deploy(counterModule);

      // todo-2 In the future, we will not need this type-cast because Ignition itself will return strongly typed contract objects.
      const typedContracts_ = {
         counter: contracts_.counter as unknown as Counter,
      };

      return typedContracts_;
   }

   // #endregion
}

// #endregion
