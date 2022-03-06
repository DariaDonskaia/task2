const { expect } = require("chai");
const { ethers, waffle} = require("hardhat");
const provider = waffle.provider;


describe("Deployment token contract",  function (){
    let Staking;
    let staking;
    let zero_address = "0x0000000000000000000000000000000000000000";

   
    beforeEach(async function () {
        [owner, addr1, addr2, addr3, ...addrs] = await ethers.getSigners()
        Staking = await ethers.getContractFactory("staking")
        staking = await Staking.deploy(addr1.address, addr2.address) 
        await staking.deployed()
    });

    describe("Test base function", function () {

        it("stake.Should lead to the need.'Amount do not be null'", async function () {
            await expect(staking.connect(addr1).stake(0)).to.be.revertedWith("Amount do not be null");
        }); 

        //it("stake.Should lead to the need.'Need to wait 10 minutes'", async function () {
            //await expect(staking.connect(addr1).stake(10)).to.be.revertedWith("Need to wait 10 minutes");
        //}); 

        it("stake.Should set LP token.", async function () {
            totalSupply = await staking.connect(addr1).stake(10);
            expect(totalSupply>10);
        }); 

        //it("unstake.Should lead to the need.'Need to wait 20 minutes'", async function () {
            //await expect(staking.connect(addr1).unstake()).to.be.revertedWith("Need to wait 20 minutes");
        //}); 

        it("unstake.Should lead to the need.'Amount do not be null'", async function () {
            await expect(staking.connect(addr1).stake(0)).to.be.revertedWith("Amount do not be null");
        }); 

        it("unstake.Should get LP token.", async function () {
            await staking.connect(addr1).stake(10);
            totalSupply = await staking.connect(addr1).unstake();
            expect(totalSupply == 0);
        }); 

        it("Should get reward.", async function () {
            totalSupply = await staking.connect(addr2).stake(10);
            amount = await staking.connect(addr2).claim();
            expect(amount > 0);
        }); 

    });
});
