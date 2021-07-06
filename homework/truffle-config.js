const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    rinkeby: {
      timeoutBlocks: 200000,
      networkCheckTimeout: 10000,

      provider: () => new HDWalletProvider(
        "de271a487141ab4e9c3d2c2c3d28342dd51fccefc93126f5aeb2fc9271e895ca",
        "https://rinkeby.infura.io/v3/b19d0e4d22e1435ea8bd86a0ad7eb2e6"
      ),
      network_id: 4,
      skipDryRun: true
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.7.3",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  },

  // Truffle DB is currently disabled by default; to enable it, change enabled: false to enabled: true
  //
  // Note: if you migrated your contracts prior to enabling this field in your Truffle project and want
  // those previously migrated contracts available in the .db directory, you will need to run the following:
  // $ truffle migrate --reset --compile-all

  db: {
    enabled: false
  }
};
