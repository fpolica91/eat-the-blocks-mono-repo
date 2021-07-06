const DEFI = artifacts.require('MyDefiProject.sol');

// 0x6d7f0754ffeb405d23c51ce938289d4835be3b14
const cDaiAddress = '0x6d7f0754ffeb405d23c51ce938289d4835be3b14';

module.exports = async done => {
  const myDeFiProject = await DEFI.deployed();
  console.log(myDeFiProject)
  await myDeFiProject.supply(cDaiAddress, web3.utils.toWei('10'));
  done();
}
