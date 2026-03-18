// #region Imports

import type {TransactionResponse} from "ethers";

// #endregion
// #region `Helpers`

export class Helpers {
   // #region `waitForTransactionReceipt`

   public static async waitForTransactionReceipt(transactionResponsePromise_: Promise<TransactionResponse>) {
      const transactionResponse_ = await transactionResponsePromise_;
      const transactionReceipt_ = await transactionResponse_.wait();
      return transactionReceipt_;
   }

   // #endregion
}

// #endregion
