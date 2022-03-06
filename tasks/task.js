const hre = require("hardhat"); 

task("stake", "Add LP token in staking contract")
  .addParam("amount", "Amount tokens")
  .setAction(async (taskArgs, hre) => {
    [owner, addr1, addr2, addr3, ...addrs] = await ethers.getSigners()
    const Staking = await ethers.getContractFactory("staking");
    staking = await Staking.deploy(addr1.address, addr2.address);  
    await staking.stake(taskArgs.amount);
    console.log("You add ", taskArgs.amount, "LP tokens ");
});

task("unstake", "Get LP tokens from staking contract")
  .setAction(async (taskArgs, hre) => {
    const Staking = await ethers.getContractFactory("staking");
    staking = await Staking.deploy(addr1.address, addr2.address);  
    await staking.unstake();
    console.log("You get", taskArgs.amount);
});


task("claim", "Get regard")
  .setAction(async (taskArgs, hre) => {
    const Staking = await ethers.getContractFactory("staking");
    staking = await Staking.deploy(addr1.address, addr2.address);  
    await staking.claim();
    console.log("You get ",taskArgs.spender);
});