// #region Imports

import type {TransactionResponse} from "ethers";

// #endregion
// #region `Helpers`

export class Helpers {
   // #region `parseBooleanEnvironmentVariable`

   public static parseBooleanEnvironmentVariable(environmentVariableName_: string, defaultValue_: boolean) {
      const rawValue_ = process.env[environmentVariableName_];
      switch(rawValue_) {
         case undefined:
         case "":
            return defaultValue_;
         case "true":
            return true;
         case "false":
            return false;
         default:
            throw new Error(`Invalid value for environment variable \`${environmentVariableName_}\`: "${rawValue_}". Shall be "true", "false", or empty.`);
      }
   }

   // #endregion
   // #region `waitForTransactionReceipt`

   public static async waitForTransactionReceipt(transactionResponsePromise_: Promise<TransactionResponse>) {
      const transactionResponse_ = await transactionResponsePromise_;
      const transactionReceipt_ = await transactionResponse_.wait();
      return transactionReceipt_;
   }

   // #endregion
}

// #endregion
