### Introduction

- This is my Hardhat 3 + Ethers + Mocha template project. I pattern my production projects after it.

- This brief read-me document assumes that the reader is familiar with Hardhat 3 and other involved technologies. It does not explain the basics.

- You might want to start with reviewing `README-PreGenerated.md`.

- I extensively use numbered comments. Be sure to understand their concept. It's described in `docs/Numbered-Comments.md`.

- There is a script for each possible command you might want to execute. Avoid executing loose commands in the terminal, such as `npx hardhat test`.

- I created this project on Linux. Some refactorings might be needed to get it working on Mac OS or Windows Subsystem for Linux, and some more refactorings to get it working on Windows itself.

- Prerequisites. Linux of a recent version; Node.JS 22+ (a Hardhat requirement); NPM of a recent version; Python 3 and PIP 3 of recent versions.

### Cloning and Preparing This Project

- Clone the repository.
```bash
git clone https://github.com/YuriyGulyayev/Hardhat-3-Ethers-Mocha-Template-Project.git
```

- You might want to `cd` to the newly created project folder, although scripts are designed to work regardless of the CWD.

- Install NPM packages, the simple way.
```bash
./scripts/NpmCleanInstall.bash
```

- Or, install NPM packages, the complex way.
```bash
./scripts/NpmInstall.bash
./scripts/NpmOutdated.bash
```
If necessary, manually edit `package.json` to increase some NPM packages versions, delete `package-lock.json` and `node_modules`, execute `./scripts/NpmInstall.bash` again.

Note that there is no script to automatically upgrade any outdated NPM packages.

- Install Python packages.
```bash
./python/launchers/CreateVirtualEnvironment.bash
./python/launchers/UpgradePackages.bash
```
Later execute the latter script again to upgrade any outdated Python packages.

- Obtain an EtherScan API key.\
Save it to the development keystore.\
Note that there are also scripts out there to target the production keystore. Feel free to use them instead.
```bash
./scripts/HardhatKeyStoreSetDevelopment.bash ETHERSCAN_API_KEY
```
When prompted, paste the value.

- Prepare a Sepolia account with some ETH in it.\
Similarly, save its private key to the development keystore.
```bash
./scripts/HardhatKeyStoreSetDevelopment.bash ETHERS_MOCHA_TEMPLATE_PROJECT_DEVELOPMENT_ETHEREUM_ACCOUNT_1_PRIVATE_KEY
```

- Note that there are scripts out there to delete configuration variables from the keystores. You might want to execute them afterwatds to delete your secrets.

### Creating a New Project Like This

I have already created this project, but if you were to create a new one like this, you would need to create a folder for it, create the `scripts` child folder, copy the `scripts/HardhatInit.bash` file to it, and execute it. When asked, choose `A TypeScript Hardhat project using Mocha and Ethers.js`. In all other prompts, leave the default choices.

### Smart Contracts

- Smart contracts are located in the `contracts` folder.

- The Hardhat project initialization wizard has created the `Counter` contract and its Solidity test contract. I refactored them a little. I have organized them into child folders and also created anther child folder named `contracts/testing-assistants` for contracts to be used in tests.

### Smart Contract Static Code Analysis

- Slither.\
See `slither/docs/Slither-Manual.md`.\
As mentioned in ToDo-202603173-1, currently, Slither does not work.

- SolHint.\
See `solhint/docs/SolHint-Manual.md`.

### Smart Contract Tests

- Solidity Tests\
Located in `contracts/tests`.

- Mocha Tests\
Located in `test/src`. The Hardhat project initialization wizard has created the tests. I refactored them a little.

### Executing Smart Contract Tests

- Executing Mocha tests against the in-process network. This also executes Solidity tests.
```bash
./tests/launchers/HardhatTest.bash
```

- Other launchers of the same tests.
```bash
./tests/launchers/HardhatTestGasStats.bash
./tests/launchers/HardhatTestCoverage.bash
```

- Executing Mocha tests against the out-of-process Hardhat Node network. This also executes Solidity tests against the in-process network.
```bash
./scripts/HardhatNode.bash
./tests/launchers/HardhatTestNetworkLocalHost.bash
```

- Executing Mocha tests against the Sepolia blockchain. This also executes Solidity tests against the in-process network.
```bash
./tests/launchers/HardhatTestNetworkSepolia.bash
```

### Smart Contract Deployment

- The Ignition deployment modules are located under `ignition/modules`. The Hardhat project initialization wizard has created them. I refactored them a little.

- When Ignition executes a deployment module to deploy contracts to an out-of-process network, it creates deployment state files under `ignition/deployments`. I have added the `ignition/deployments/chain-31337` folder to `.gitignore`.

### Deploying Smart Contracts

- Deploying to the default in-process network. The result will be immediately discarded. So this is really a quick smoke test.
```bash
./ignition/launchers/HardhatIgnitionDeployCounterDefaultNetwork.bash
```

- Deploying to the out-of-process Hardhat Node network.
```bash
./scripts/HardhatNode.bash
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

### Other Files

There are some other files in the project that this document does not mention. You might want to explore all of them.
