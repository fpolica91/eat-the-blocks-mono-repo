pragma solidity 0.7.3;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LPToken is ERC20 {
    constructor() ERC20("LP Token", "LP") {}
}
