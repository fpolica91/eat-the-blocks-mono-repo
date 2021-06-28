pragma solidity 0.7.3;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Governancetoken.sol";
import "./Lptoken.sol";
import "./Underlyingtoken.sol";

contract LiquityPool is LPToken {
    mapping(address => uint256) public checkpoints;
    Underlyingtoken public underlyingToken;
    GovernanceToken public governanceToken;
    uint256 public constant REWARD_PER_BLOCK = 1;

    constructor(address _underlyingToken, address _governanceToken) {
        underlyingToken = _underlyingToken;
        governanceToken = _governanceToken;
    }

    // function for the user to transfer tokens into the Liquidity pool contract
    function deposit(uint256 amount) external {
        if (checkpoints[msg.sender] == 0) {
            // if the user has not deposited before, set the checkpoint to the current block
            checkpoints[msg.sender] = block.number;
        }
        // else distribute rewards
        _distributeRewards(msg.sender);
        underlyingToken.transferFrom(msg.sender, address(this), amount);
        _mint(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "not enough tokens");
        _distributeRewards(msg.sender);
        underlyingToken.transfer(msg.sender, amount);
        _burn(msg.sender, amount);
    }

    function _distributeRewards(address beneficiary) internal {
        // current checkpoint of the user
        uint256 checkpoint = checkpoints[beneficiary];
        // if the current block minus the current checkpoint is greater than 0 we owe tokens
        if (block.number - checkpoint > 0) {
            // example initial checkpoint is 10
            // current block.number is 15
            // balance deposited is 100 and REWARD_PER_BLOCK is 1;
            // we owe 100 * 5 * 1;
            uint256 distributionAmouint = balanceOf(beneficiary) *
                (block.number - checkpoint) *
                REWARD_PER_BLOCK;
            governanceToken.mint(beneficiary, distributionAmouint);
            checkpoints[beneficiary] = block.number;
        }
    }
}
