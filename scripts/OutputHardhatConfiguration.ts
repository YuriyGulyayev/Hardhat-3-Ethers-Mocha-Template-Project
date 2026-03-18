// import assert from "node:assert";
import type {ChainType, NetworkConnection} from "hardhat/types";
import hre from "hardhat";

export class Main implements AsyncDisposable {
   private _networkConnection: NetworkConnection<ChainType> | undefined;

   public static async create() {
      const main_ = new Main();
      main_._networkConnection = await hre.network.connect();
      return main_;
   }

   private constructor() {}

   public async [Symbol.asyncDispose]() {
      const networkConnection_ = this._networkConnection;
      if(networkConnection_ != undefined) {
         this._networkConnection = undefined;
         await networkConnection_.close();
      }
   }

   public async main() {
      // assert.strict(false);
      console.info("%s", Main.stringifyObject(hre.config));
      console.info();
      const signers_ = await ( this._networkConnection ! ).ethers.getSigners();
      console.info("%s", Main.stringifyObject(signers_));
   }

   public static stringifyObject(value_: object) {
      return (
         JSON.stringify(
            value_,
            (_key_, value2_) => ((typeof value2_ == "bigint") ? `${value2_}n` : value2_),
            3
         )
      );
   }
}

{
   await using main_ = await Main.create();
   await main_.main();
}
