// #region Imports

import type {TransactionResponse,} from "ethers";

// #endregion
// #region `waitForTransactionReceipt`

export async function waitForTransactionReceipt(transactionResponsePromise_: Promise<TransactionResponse>, confirms_?: number, timeout_?: number) {
   const transactionResponse_ = await transactionResponsePromise_;
   const transactionReceipt_ = await transactionResponse_.wait(confirms_, timeout_);
   return transactionReceipt_;
}

// #endregion
