// import assert from "node:assert";
import type {ChainType, NetworkConnection,} from "hardhat/types";
import hre from "hardhat";

export class Main implements AsyncDisposable {
   private _networkConnection: NetworkConnection<ChainType> | undefined;

   // public constructor() {}

   public async prepare() {
      this._networkConnection = await hre.network.connect();
   }

   public async [Symbol.asyncDispose]() {
      const networkConnection_ = this._networkConnection;
      if(networkConnection_ != undefined) {
         this._networkConnection = undefined;
         await networkConnection_.close();
      }
   }

   public async main() {
      console.info("%s", Main._stringifyObject(hre.config));
      console.info();
      const signers_ = await ( this._networkConnection ! ).ethers.getSigners();
      console.info("%s", Main._stringifyObject(signers_));
   }

   private static _stringifyObject(value_: object) {
      return (
         JSON.stringify(
            value_,
            (_key_, value2_: unknown) => ((typeof value2_ == "bigint") ? `${value2_}n` : value2_),
            3
         )
      );
   }
}

{
   await using main_ = new Main();
   await main_.prepare();
   await main_.main();
}
