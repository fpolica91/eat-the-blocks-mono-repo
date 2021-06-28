pragma solidity 0.7.3;
import "./IFlashLoanUser.sol";
import "./FlashLoanProvider.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FlashLoanUser is IFlashLoanUser {
    function startFlashLoan(
        address flashLoanProvider,
        uint256 amount,
        address token
    ) external {
        FlashLoanProvider(flashLoanProvider).executeFlashLoan(
            address(this),
            amount,
            token,
            bytes("pay back")
        );
    }

    function flashLoanCallback(
        uint256 amount,
        address token,
        bytes memory data
    ) external override {
        //do some arbitrage, liquidation, etc
        IERC20(token).transfer(msg.sender, amount);
    }
}
