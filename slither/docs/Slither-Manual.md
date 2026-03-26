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

- But don't execute Slither directly; execute this instead:
```
./slither/launchers/Slither.bash
```

### Slither Reports

- Slither report is saved to `slither/reports/SlitherReport2.txt`.

- If the report file already exists it will be renamed to `SlitherReport1.txt`. If the latter also exists it will be trashed beforehand.

- To compare the last 2 reports, execute:
```
./slither/launchers/DiffSlitherReports.bash
```

- Open the report file in VS Code and press Ctrl+Shift+V to open Markdown Preview. In there, you can click links to navigate to relevant locations in Solidity source files.

### Slither Configuration

- `slither.config.json` is the Slither config file.

### Slither Docs

https://github.com/crytic/slither

https://github.com/crytic/slither/wiki

https://github.com/crytic/slither/wiki/Usage
