// #region Imports

import NodeOs from "node:os";
import NodePath from "node:path";
import NodeFs from "node:fs";
import hre from "hardhat";

// #endregion
// #region Data

let _warnIfDeploymentStateExistsOnceWasCalled = false;

// #endregion
// #region `warnIfDeploymentStateExistsOnce`

/** This is a simplified and less correct implementation of Comment-202603203. */
export /* async */ function warnIfDeploymentStateExistsOnce() {
   if(_warnIfDeploymentStateExistsOnceWasCalled) {
      return;
   }
   _warnIfDeploymentStateExistsOnceWasCalled = true;

   // Issue. `hre.globalOptions.network` type is `string`, but I have observed that it's `undefined`
   // when not specified in the command line.
   // So we are going to check for `undefined`. And to silence a lint there, we must specify that this variable can be `undefined`.
   // todo-2 Check if they have fixed this variable type.
   const networkName_ = hre.globalOptions.network as string | undefined;

   // console.info("%s", networkName_);
   if(networkName_ == undefined) {
      return;
   }
   const networkConfig_ = hre.config.networks[networkName_];
   const networkIsInProcess_ = networkConfig_.type == "edr-simulated";
   if(networkIsInProcess_) {
      return;
   }
   // console.info("%d", networkConfig_.chainId);
   const deploymentId_ = `chain-${networkConfig_.chainId}`;
   // console.info("%s", deploymentId_);
   const deploymentStateFolderPath_ = NodePath.join(import.meta.dirname, "../deployments", deploymentId_);
   // console.info("%s", deploymentStateFolderPath_);
   if(NodeFs.existsSync(deploymentStateFolderPath_)) {
      // [Comment-202603205/]
      console.warn("%s", `${NodeOs.EOL}Warning. The \`ignition/deployments/${deploymentId_}\` folder already exists.${NodeOs.EOL}`);
   }
}

// #endregion
// #region // [Comment-202603203/]

// Question to ChatGPT:
// I need a function in typescript that checks if given the default or povided in the command line network type is such that ignition would create deployment state folder and the folder exists. If so, print a warning to the console. The typescript file containing this function will be located in the `ignition/src` subfolder in the project folder, so use the typescript file path to obtain the folder path in which deployment state folder is located. Or if possible use a designated API if one is available in Hardhat to obtain the folder path in which deployment state folder is located. Really, if possible, use designated APIs for everything. Maybe one is available to check if ignition deloyment state exists.

// Answer.
//
// I’m checking the current Hardhat 3 Ignition APIs and folder conventions so the function uses documented surfaces where they exist and only falls back to path logic where necessary.
//
// I couldn’t verify a public Hardhat/Ignition API for “give me the deployment-state directory” or “tell me whether Ignition state already exists.” The public pieces I could verify are: Hardhat exposes the selected/default network through the HRE and network.connect(), network configs have type values edr-simulated or http, Ignition stores deployment artifacts under ./ignition/deployments, the default deployment id is chain-<chainId>, and journal.jsonl is the main state file. Also, for the in-memory network, the CLI only writes deployment info to disk when --write-localhost-deployment is enabled, and its default is false. (Hardhat)
// Given that, this is the cleanest function I’d use in a file located under ignition/src. It uses Hardhat’s public APIs for network selection and chain id, and falls back to deriving the deployment-artifacts path from the current file location:
// import hre from "hardhat";
// import fs from "node:fs";
// import path from "node:path";
// import { fileURLToPath } from "node:url";
//
// export interface WarnIfIgnitionStateExistsOptions {
//   /**
//    * Optional explicit network name.
//    * If omitted, this uses the network selected by --network / HARDHAT_NETWORK,
//    * or "default" if none was provided.
//    */
//   networkName?: string;
//
//   /**
//    * Optional explicit deployment id.
//    * If omitted, the default Ignition deployment id is used: chain-<chainId>.
//    */
//   deploymentId?: string;
//
//   /**
//    * Set this to true only if you are intentionally writing Ignition state
//    * for an in-process simulated network.
//    *
//    * This mirrors the CLI flag:
//    *   --write-localhost-deployment
//    *
//    * For non-in-process networks this option is ignored.
//    */
//   writeLocalhostDeployment?: boolean;
//
//   /**
//    * Optional warning sink.
//    */
//   warn?: (message: string) => void;
// }
//
// export interface IgnitionStateCheckResult {
//   networkName: string;
//   networkType: "edr-simulated" | "http";
//   deploymentId: string;
//   deploymentsDir: string;
//   deploymentDir: string;
//   journalPath: string;
//   isInProcessNetwork: boolean;
//   wouldWriteStateToDisk: boolean;
//   stateExists: boolean;
// }
//
// function getIgnitionDeploymentsDirFromThisFile(): string {
//   // This file is assumed to live in: <project>/ignition/src/<file>.ts
//   // So the deployments dir is:        <project>/ignition/deployments
//   const thisFilePath = fileURLToPath(import.meta.url);
//   const thisDir = path.dirname(thisFilePath);
//
//   return path.resolve(thisDir, "..", "deployments");
// }
//
// function getSelectedNetworkName(
//   options: WarnIfIgnitionStateExistsOptions,
// ): string {
//   return options.networkName ?? hre.globalOptions.network ?? "default";
// }
//
// async function getDefaultDeploymentId(networkName: string): Promise<string> {
//   const { provider } = await hre.network.connect(networkName);
//   const chainIdHex = await provider.request({ method: "eth_chainId" });
//
//   if (typeof chainIdHex !== "string") {
//     throw new Error(
//       `eth_chainId returned a non-string value for network ${networkName}`,
//     );
//   }
//
//   return `chain-${BigInt(chainIdHex).toString(10)}`;
// }
//
// export async function warnIfIgnitionDeploymentStateExists(
//   options: WarnIfIgnitionStateExistsOptions = {},
// ): Promise<IgnitionStateCheckResult> {
//   const networkName = getSelectedNetworkName(options);
//   const networkConfig = hre.config.networks[networkName];
//
//   if (networkConfig === undefined) {
//     throw new Error(`Unknown Hardhat network config: ${networkName}`);
//   }
//
//   const networkType = networkConfig.type;
//   const isInProcessNetwork = networkType === "edr-simulated";
//
//   // For in-memory simulated networks, Hardhat Ignition's CLI only writes state
//   // when --write-localhost-deployment is enabled. For all non-in-process
//   // networks, deployment artifacts are written normally.
//   const wouldWriteStateToDisk =
//     !isInProcessNetwork || options.writeLocalhostDeployment === true;
//
//   const deploymentId =
//     options.deploymentId ?? (await getDefaultDeploymentId(networkName));
//
//   const deploymentsDir = getIgnitionDeploymentsDirFromThisFile();
//   const deploymentDir = path.join(deploymentsDir, deploymentId);
//   const journalPath = path.join(deploymentDir, "journal.jsonl");
//
//   // Checking for journal.jsonl is more precise than checking only the folder,
//   // because journal.jsonl is Ignition's main state file.
//   const stateExists = wouldWriteStateToDisk && fs.existsSync(journalPath);
//
//   if (stateExists) {
//     const warn = options.warn ?? console.warn;
//     warn(
//       [
//         `Warning: Ignition deployment state already exists.`,
//         `network=${networkName}`,
//         `deploymentId=${deploymentId}`,
//         `journal=${journalPath}`,
//       ].join(" "),
//     );
//   }
//
//   return {
//     networkName,
//     networkType,
//     deploymentId,
//     deploymentsDir,
//     deploymentDir,
//     journalPath,
//     isInProcessNetwork,
//     wouldWriteStateToDisk,
//     stateExists,
//   };
// }
// A minimal use looks like this:
// const state = await warnIfIgnitionDeploymentStateExists();
//
// if (state.stateExists) {
//   // decide whether to abort, prompt, or continue
// }
// And if you deploy with a custom deployment id:
// await warnIfIgnitionDeploymentStateExists({
//   deploymentId: "my-custom-id",
// });
// And if you intentionally persist an in-process simulated deployment:
// await warnIfIgnitionDeploymentStateExists({
//   writeLocalhostDeployment: true,
// });
// Two caveats matter here.
// First, if you deploy with --deployment-id <id>, you need to pass that same id into the function; otherwise it will check the default chain-<chainId> folder. Ignition’s default folder naming is chain-<chainId>, but custom deployment ids override that. (Hardhat)
// Second, the docs are slightly awkward around simulated networks: one guide broadly says Ignition creates a deployment folder, while the CLI reference says in-memory deployments are only written to disk with --write-localhost-deployment, default false. The function above follows the CLI reference for edr-simulated networks. (Hardhat)
// If you want, I can adapt this into a helper that throws instead of warning, or one that also detects --deployment-id from your task arguments.

// #endregion
