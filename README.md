## Hardhat-3-Ethers-Mocha-Template-Project

### Introduction

- This is my Hardhat 3 + Ethers + Mocha template project. I pattern my production projects after it.

- This brief read-me document assumes that the reader is familiar with Hardhat 3 and other involved technologies. It does not explain the basics.

- You might want to start with reviewing `README_PreGenerated.md`.

- I extensively use numbered comments. Be sure to understand their concept. It's described in `docs/Numbered-Comments.md`.

- There is a script for each possible command you might want to execute. Avoid executing loose commands in the terminal, such as `npx hardhat test`.

- I created this project on Ubuntu Cinnamon Linux 24.04 LTS. Some refactorings might be needed to get things working on a different Linux distro, Mac OS, or Windows Subsystem for Linux, and some more refactorings to get it working on Windows itself.

- Prerequisites. Linux of a recent version (I use Ubuntu Cinnamon 24.04 LTS); Node.JS 22+ (a Hardhat requirement); NPM of a recent version; Python 3 and PIP 3 of recent versions; an Integrated Development Environment, such as Visual Studio Code.

### Cloning and Preparing This Project

- Clone the repository.
  
  ```bash
  git clone https://github.com/YuriyGulyayev/Hardhat-3-Ethers-Mocha-Template-Project.git
  ```

- `cd` to the newly created project folder. Although scripts are designed to work regardless of the CWD.

- Install NPM packages.
  
  ```bash
  ./scripts/NpmCleanInstall.bash
  ```

- Install Python packages.
  
  ```bash
  ./python/launchers/ReCreateVirtualEnvironment.bash
  ./python/launchers/UpgradePackages.bash
  ```

- Obtain an EtherScan API key. Save it to the development keystore.
  
  ```bash
  ./scripts/HardhatKeyStoreSetDevelopment.bash ETHERSCAN_API_KEY
  ```

  When prompted, paste the value.

  Note that there are also scripts out there to target the production keystore. Feel free to use them instead, but you will have to deal with password prompts.

- Prepare a Sepolia account with some ETH in it. Similarly, save its private key to the development keystore.
  
  ```bash
  ./scripts/HardhatKeyStoreSetDevelopment.bash ETHERS_MOCHA_TEMPLATE_PROJECT_DEVELOPMENT_ETHEREUM_ACCOUNT_1_PRIVATE_KEY
  ```

- Open the project folder with an Integrated Development Environment, such as Visual Studio Code.

  ```bash
  code .
  ```

### Smart Contracts

- Smart contracts are located in the `contracts` folder.

- The Hardhat project initialization wizard has created the `Counter` contract and its Solidity test contract. I have refactored them. I have organized them into child folders, and also created anther child folder named `contracts/testing-assistants` for contracts to be used in tests.

### Smart Contract Static Code Analysis

- Slither.\
See `slither/docs/Slither-Manual.md`.

- SolHint.\
See `solhint/docs/SolHint-Manual.md`.

### Smart Contract Tests Overview

- Solidity Tests\
Located in the `contracts/tests` folder.\
The Hardhat project initialization wizard has created the tests. I have refactored them.

- Mocha Tests\
Located in the `test/src/tests` folder.\
The Hardhat project initialization wizard has created the tests. I have refactored them and developed their launcher scripts.

### Executing Smart Contract Tests

- Executing Mocha tests against the default in-process network. This also executes Solidity tests.

  ```bash
  ./test/launchers/HardhatTest.bash
  ```

- Other launchers of the same tests.

  ```bash
  ./test/launchers/HardhatTestGasStats.bash
  ./test/launchers/HardhatTestCoverage.bash
  ```

- Executing Mocha tests against the out-of-process Hardhat Node network. This also executes Solidity tests against the default in-process network.

  ```bash
  ./scripts/HardhatNode.bash
  ```
  
  Then in a different terminal:
  
  ```bash
  ./test/launchers/HardhatTestNetworkLocalHost.bash
  ```
  
  You can execute the tests multiple times, but pay attention to the warning printed near Comment-202603205.

### Smart Contract Deployment Overview

- Ignition is used for the deployment.

- The Ignition deployment modules are located under `ignition/modules`. The Hardhat project initialization wizard has created them. I have refactored them.

- It's safe to deploy to the same out-of-process network multiple times, but Ignition will skip actions it has already performed.

- When Ignition deploys contracts to an out-of-process network, it creates deployment state folders under `ignition/deployments`.\
Pay attention to the warning printed near Comment-202603205.\
The Ignition deployment state folders should, in most cases, be committed to the Git repo, except for the `ignition/deployments/chain-31337` folder, which, according to Comment-202604207, should be manually deleted.

### Deploying Smart Contracts

- Deploying to the default in-process network. All state changes will be immediately discarded. So this is really a quick smoke test.

  ```bash
  ./ignition/launchers/HardhatIgnitionDeployCounterDefaultNetwork.bash
  ```

- Deploying to the out-of-process Hardhat Node network.

  ```bash
  ./scripts/HardhatNode.bash
  ```
  
  Then in a different terminal:
  
  ```bash
  ./ignition/launchers/HardhatIgnitionDeployCounterLocalHost.bash
  ```

- Deploying to the Sepolia blockchain.

  ```bash
  ./ignition/launchers/HardhatIgnitionDeployCounterSepolia.bash
  ```

- The same, plus also verifying the deployed contract on EtherScan.

  ```bash
  ./ignition/launchers/HardhatIgnitionDeployVerifyCounterSepolia.bash
  ```

### TypeScript Static Code Analysis

- Type-Checking.\
See `typescript/docs/TypeScript-Manual.md`.

- ESLint.\
See `eslint/docs/EsLint-Manual.md`.

### Increasing the Solidity Compiler Version

- Perform a global search for `0.8.29` and replace it with a newer version number.

- Take a look at ToDo-202605051-2.

### Installing, Uninstalling, and Updating NPM Packages

- Installing dev NPM packages.

  ```bash
  ./scripts/NpmInstallDevDependencies.bash <package-names>
  ```

- Uninstalling NPM packages.

  ```bash
  ./scripts/NpmUninstallDependencies.bash <package-names>
  ```

- Updating NPM packages.

  ```bash
  ./scripts/NpmOutdated.bash
  ```
  
  Pay attention to the warning logged near Comment-202603185.\
  If any packages need updating, manually increase their versions in `package.json`. Then execute:

  ```bash
  ./scripts/NpmInstallWithPackageLockFileReGeneration.bash
  ```

### Updating Python Packages

- Execute:

  ```bash
  ./python/launchers/UpgradePackagesDryRun.bash
  ./python/launchers/ListOutdatedPackages.bash
  ```
  
  If any packages need updating, manually increase their versions in `requirements.txt`. Then execute:

  ```bash
  ./python/launchers/ReCreateVirtualEnvironment.bash
  ./python/launchers/UpgradePackages.bash
  ```

### Deleting Artifacts Left Outside the Project Folder

- Delete the keystore entries you have created with `./scripts/HardhatKeyStoreSetDevelopment.bash`.

  ```bash
  ./scripts/HardhatKeyStoreDeleteDevelopment.bash <key-name>
  ```

### Creating a New Project Like This

- I have already created this project, but if you were to create a new one like this, you would need to create a folder for it, create the `scripts` child folder, copy the `scripts/HardhatInit.bash` file to it, and execute it. When prompted, choose `A TypeScript Hardhat project using Mocha and Ethers.js`. In all other prompts, leave the default choices.

### Other Files

- There are some other files in the project that this document does not mention. You might want to explore all of them.
