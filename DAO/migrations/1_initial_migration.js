const DAO = artifacts.require("DAO");

module.exports = async function (deployer) {
  await deployer.deploy(DAO, "0x6B175474E89094C44Da98b954EedeAC495271d0F");
};
