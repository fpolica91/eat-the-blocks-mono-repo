pragma solidity 0.7.3;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Underlyingtoken is ERC20 {
    constructor() ERC20("Underlying Token", "UT") {}

    function faucet(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
