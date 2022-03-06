const hre = require("hardhat"); 

async function main() {
[owner, addr1, addr2, addr3, ...addrs] = await ethers.getSigners()
  console.log("Deploying contracts with the account:", deployer.address); 

  const Staking = await hre.ethers.getContractFactory("staking"); 
  const staking = await Staking.deploy(addr1.address, addr2.address); 

  await staking.deployed(); 

  console.log("staking contract deployed to:", staking.address); 
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 