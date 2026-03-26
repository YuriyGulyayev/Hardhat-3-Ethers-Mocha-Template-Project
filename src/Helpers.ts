// #region `parseBooleanEnvironmentVariable`

export function parseBooleanEnvironmentVariable(environmentVariableName_: string, defaultValue_: boolean) {
   const rawValue_ = process.env[environmentVariableName_];
   switch(rawValue_) {
      case undefined:
      case "":
         return defaultValue_;
      case "true":
         return true;
      case "false":
         return false;
      default:
         throw new Error(`Invalid value for environment variable \`${environmentVariableName_}\`: "${rawValue_}". Shall be "true", "false", or empty.`);
   }
}

// #endregion
