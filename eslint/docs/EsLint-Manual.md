### How to Execute ESLint

- Execute:
```bash
./eslint/launchers/EsLint.bash
```

### ESLint Reports

- ESLint report is saved to `eslint/reports/EsLintReport2.txt`.

- If the report file already exists it will be renamed to `EsLintReport1.txt`. If the latter also exists it will be trashed beforehand.

- To compare the last 2 reports, execute:
```
./eslint/launchers/DiffEsLintReports.bash
```

### ESLint Configuration

- `eslint.config.ts` is the ESLint config file.
