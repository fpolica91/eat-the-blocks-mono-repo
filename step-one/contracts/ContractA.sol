pragma solidity 0.7.3;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ContractB {
    function deposit(uint256 _amount) external;

    function withdraw(uint256 _amount) external;
}

contract ContractA {
    IERC20 public token;
    ContractB public contractB;

    constructor(address _token, address _contractB) {
        token = IERC20(_token);
        contractB = ContractB(_contractB);
    }

    function deposit(uint256 _amount) external {
        token.transferFrom(msg.sender, address(this), _amount);
        token.approve(address(contractB), _amount);
        contractB.deposit(_amount);
    }

    function withdraw(uint256 _amount) external {
        contractB.withdraw(_amount);
        token.transfer(msg.sender, _amount);
    }
}
