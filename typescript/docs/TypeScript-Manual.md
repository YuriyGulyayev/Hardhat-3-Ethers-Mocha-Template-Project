### Inroduction

- For performance reasons, Hardhat won't type-check your project when you run a task. You can explicitly enable type-checking with the `--typecheck` flag. But it will not necessarily type-check all TypeScript sources.

### How to Type-Check All TypeScript Sources

- Execute:

```bash
./typescript/launchers/TypeCheck.bash
```

### Type-Checking Reports

- Type-Checking report is saved to `typescript/reports/TypeCheckReport2.txt`.

- If the report file already exists it will be renamed to `TypeCheckReport1.txt`. If the latter also exists it will be trashed beforehand.

- To compare the last 2 reports, execute:

```bash
./typescript/launchers/DiffTypeCheckReports.bash
```
