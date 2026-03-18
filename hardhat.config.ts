// #region

import {configVariable, defineConfig} from "hardhat/config";
import hardhatToolboxMochaEthersPlugin from "@nomicfoundation/hardhat-toolbox-mocha-ethers";

// #endregion
// #region

/** This account holds no ETH. It's used to help you to not forget to explicitly specify each transaction sender account. */
const dummySigner1PrivateKey = "0xd0e6977c616b009a029cc707df36de114da5570b5ff5f9dc64e7d24d6f474ad8";

// #endregion
// #region

export default defineConfig(
   {
      // #region `plugins`

      plugins: [hardhatToolboxMochaEthersPlugin,],

      // #endregion
      // #region `paths`

      paths: {
         tests: "./test/src",
      },

      // #endregion
      // #region `solidity`

      solidity: {
         profiles: {
            default: {
               // I dislike the idea of using the default profile, because using different profiles for development and production
               // can result in missing issues during the development.
               // So poizoning this profile configuration.
               version: "0.5.1",
            },
            production: {
               compilers: [
                  {
                     version: "0.8.29",
                     settings: {
                        // todo-3 Is this parameter going to eventually become the default?
                        viaIR: true,

                        optimizer: {
                           // // In the production profile, by default, this is `true`.
                           // enabled: true,

                           // By default, this is 200.
                           // A big value can cause excessive inlining, which sometimes is not the best option.
                           runs: 400,
                        },
                     },
                  },
               ],
            },
         },
      },

      // #endregion
      // #region `test`

      test: {
         mocha: {
            parallel: true,
            timeout: 60 * 60 * 1e3,
         },
      },

      // #endregion
      // #region `verify`

      verify: {
         etherscan: {
            apiKey: configVariable("ETHERSCAN_API_KEY"),
         },
      },

      // #endregion
      // #region `networks`

      networks: {
         default: {
            // type: "edr-simulated";
            chainType: "generic",
            // chainId: 31337,
            // gasMultiplier: ,
            // accounts: [],
            // allowUnlimitedContractSize: ,
            // allowBlocksWithSameTimestamp: ,
            // mining: {},
         },
         node: {
            // type: "edr-simulated",
            chainType: "generic",
            // chainId: 31337,
            // gasMultiplier: ,
            // accounts: [],
            // allowUnlimitedContractSize: ,
            allowBlocksWithSameTimestamp: true,
            mining: {
               auto: false,
               interval: 100,
               // mempool: {},
            },
         },
         localhost: {
            // type: "http",
            chainType: "generic",
            chainId: 31337,
            gasMultiplier: 1.1,
            // accounts: "remote",
            // url: ,
         },

         // // We don't currently need any networks like these.
         // // But if we do, it could make sense to create separate configurations simular to `node` and `localhost`.
         // hardhatEdrSimulatedL1: {
         //    type: "edr-simulated",
         //    chainType: "l1",
         //    // chainId: 31337,
         //    // gasMultiplier: ,
         //    // accounts: [],
         //    // allowUnlimitedContractSize: ,
         //    // allowBlocksWithSameTimestamp: ,
         //    // mining: {},
         // },
         // hardhatEdrSimulatedOp: {
         //    type: "edr-simulated",
         //    chainType: "op",
         //    // chainId: 31337,
         //    // gasMultiplier: ,
         //    // accounts: [],
         //    // allowUnlimitedContractSize: ,
         //    // allowBlocksWithSameTimestamp: ,
         //    // mining: {},
         // },
         // hardhatEdrSimulatedGeneric: {
         //    type: "edr-simulated",
         //    chainType: "generic",
         //    // chainId: 31337,
         //    // gasMultiplier: ,
         //    // accounts: [],
         //    // allowUnlimitedContractSize: ,
         //    // allowBlocksWithSameTimestamp: ,
         //    // mining: {},
         // },

         sepolia: {
            type: "http",
            chainType: "l1",
            chainId: 11155111,
            gasMultiplier: 1.1,
            accounts: [dummySigner1PrivateKey, configVariable("ETHERS_MOCHA_TEMPLATE_PROJECT_DEVELOPMENT_ETHEREUM_ACCOUNT_1_PRIVATE_KEY"),],
            url: "https://ethereum-sepolia.publicnode.com",
         },
      },

      // #endregion
   }
);

// #endregion
