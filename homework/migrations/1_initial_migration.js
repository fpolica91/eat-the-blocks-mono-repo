const MyDefiProject = artifacts.require("MyDefiProject");

module.exports = function (deployer, network) {
  if (network === 'rinkeby') {

    const comptrollerAddress = '0x2eaa9d77ae4d8f9cdd9faacd44016e746485bddb';
    const priceOracleProxy = '0x5722A3F60fa4F0EC5120DCD6C386289A4758D1b2';
    deployer.deploy(MyDefiProject, comptrollerAddress, priceOracleProxy);
  }

};
