require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-web3");
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
 
  paths: {
    sources: "./contracts",
    tests: "./tests",
    cache: "./cache",
    artifacts: "./artifacts",
    task: "./tasks"
  },
};
/*
 networks: {
    rinkeby: {
    url: `https://eth-rinkeby.alchemyapi.io/v2/${process.env.ALCHEMY_API_KEY}`,
    accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: `${process.env.ETHERSCAN_API_KEY}`
  },
  */