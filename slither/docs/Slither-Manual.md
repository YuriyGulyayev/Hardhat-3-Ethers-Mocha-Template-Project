As mentioned in ToDo-202603173-2, Slither does not currently work.

### About Slither

- Slither is a Python package.

### How to Execute Slither

- You can run Slither in a Hardhat/Foundry/Dapp/Brownie project folder.
```bash
./.venv/bin/slither .
```

- Or, provided Slither is installed globally, you can run it in a different folder and specify a project folder in the command line.
```bash
slither path/to/hardhat-project
```

- Slither supports a number of command line parameters, some of which the `slither/launchers/Slither.bash` script provides.

- Don't execute Slither directly; execute the script instead.\
It will generate a markdown report file in the folder above the project root folder.

- Open the file in VS Code and press Ctrl+Shift+V to open Markdown Preview. In there, you can click links to navigate to relevant locations in Solidity source files.

### Slither Docs

https://github.com/crytic/slither

https://github.com/crytic/slither/wiki

https://github.com/crytic/slither/wiki/Usage
