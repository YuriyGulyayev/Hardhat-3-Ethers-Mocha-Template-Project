import globals from "globals";
import js from "@eslint/js";
import tseslint from "typescript-eslint";
import stylistic from "@stylistic/eslint-plugin";
import {globalIgnores, defineConfig,} from "eslint/config";

export default defineConfig(
   // Comment-202603263 applies.
   globalIgnores(
      [
         // "node_modules/**",

         // Comment-202603122 applies.
         "dist/**",

         // Comment-202603261 applies.
         "bundle/**",

         ".venv/**",
         "cache/**",
         "artifacts/**",
         "types/**",
         "coverage/**",
         "ignition/deployments/**",
      ]
   ),

   {
      files: ["**/*.{ts,mts,cts}",],

      // It's unnecessary to explicitly specify any plugins here because we implicitly inject them by using their rules.
      // But refactoring can break things, so let's do it.
      // It's still unnecessary to list the `js` plugin here, because it's a built-in, not a plugin.
      plugins: {
         "@typescript-eslint": tseslint.plugin,
         "@stylistic": stylistic,
      },

      languageOptions: {
         parserOptions: {
            projectService: true,
         },
         globals: globals.node,
      },
      extends: [
         js.configs.recommended,
         tseslint.configs.strictTypeChecked,
         tseslint.configs.stylisticTypeChecked,
         stylistic.configs.customize(
            {
               semi: true,
               quotes: "double",
               indent: 3,
               // jsx: false,
            }
         ),
      ],
      rules: {
         "@typescript-eslint/no-non-null-assertion": "off",
         "@typescript-eslint/restrict-template-expressions": [
            "error",
            {
               allowNumber: true,
               allowBoolean: true,
               allowRegExp: true,
               allowArray: true,
               allowAny: true,
               allowNullish: true,
            },
         ],
         "@stylistic/comma-dangle": [
            "error",
            {
               arrays: "always",
               objects: "always",
               imports: "always",
               exports: "always",
               // functions: "never",
               importAttributes: "always",
               dynamicImports: "always",
               enums: "always",
               // generics: "never",
               tuples: "always",
            },
         ],
         "@stylistic/keyword-spacing": [
            "error",
            {
               // after: true,
               overrides: {
                  if: {after: false,},
                  for: {after: false,},
                  while: {after: false,},
                  switch: {after: false,},
               },
            },
         ],
         "@stylistic/space-unary-ops": [
            "error",
            {
               // words: true,
               // nonwords: false,
               nonwords: true,
               // overrides: {
               //    "++": true,
               //    "--": true,
               //    "!": true,
               //    "ts-non-null": true,
               // },
            },
         ],
         "@stylistic/space-in-parens": "off",
         "@stylistic/object-curly-spacing": "off",
         "@stylistic/operator-linebreak": ["error", "after",],
      },
   },

   {
      files: ["test/**/*.{ts,mts,cts}",],
      languageOptions: {
         globals: {
            ...globals.node,
            ...globals.mocha,
         },
      },
   }

   // // We do not treat these files differently.
   // {
   //    files: ["eslint.config.ts", "hardhat.config.ts",],
   //    languageOptions: {
   //       globals: globals.node,
   //       parserOptions: {
   //          projectService: true,
   //       },
   //    },
   // }

   // // This is unnecessary. We aren't supposed to have any `.js` files.
   // {
   //    files: ["**/*.{js,mjs,cjs}",],
   //    extends: [tseslint.configs.disableTypeChecked,],
   // }
);
