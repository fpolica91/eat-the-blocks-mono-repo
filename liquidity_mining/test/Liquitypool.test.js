const { time } = require('@openzeppelin/test-helpers');
const UnderLyingtoken = artifacts.require('Underlyingtoken.sol')
const Governancetoken = artifacts.require('Governancetoken.sol')
const LiquidityPool = artifacts.require('LiquityPool.sol')

contract('liquidityPool', accounts => {
  const [admin, trader1, trader2, _] = accounts;
  let underlyingToken, governanceToken, liquidityPool;

  beforeEach(async () => {
    underlyingToken = await UnderLyingtoken.new();
    governanceToken = await Governancetoken.new();
    liquidityPool = await LiquidityPool.new(
      underlyingToken.address,
      governanceToken.address
    );
    await governanceToken.transferOwnership(liquidityPool.address);
    await Promise.all([
      underlyingToken.faucet(trader1, web3.utils.toWei('1000')),
      underlyingToken.faucet(trader2, web3.utils.toWei('1000'))
    ])
  })
  it('should mint 400 governance token', async () => {
    await underlyingToken.approve(
      liquidityPool.address,
      web3.utils.toWei('100'),
      { from: trader1 }
    );
    await liquidityPool.deposit(web3.utils.toWei('100'), { from: trader1 });
    await time.advanceBlock();
    await time.advanceBlock();
    await time.advanceBlock();
    await liquidityPool.withdraw(web3.utils.toWei('100'), { from: trader1 });
    const balanceGovToken = await governanceToken.balanceOf(trader1);
    assert(web3.utils.fromWei(balanceGovToken.toString()) === '400');
  });


  it('should mint 600 governance token', async () => {
    await underlyingToken.approve(
      liquidityPool.address,
      web3.utils.toWei('100'),
      { from: trader1 }
    );
    await liquidityPool.deposit(web3.utils.toWei('100'), { from: trader1 });
    await time.advanceBlock();
    await time.advanceBlock();
    await time.advanceBlock();
    await time.advanceBlock();
    await underlyingToken.approve(
      liquidityPool.address,
      web3.utils.toWei('100'),
      { from: trader1 }
    );
    await liquidityPool.withdraw(web3.utils.toWei('100'), { from: trader1 });
    const balanceGovToken = await governanceToken.balanceOf(trader1);
    assert(web3.utils.fromWei(balanceGovToken.toString()) === '600');
  });
})