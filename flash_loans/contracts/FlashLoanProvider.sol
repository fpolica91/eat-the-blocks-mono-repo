pragma solidity 0.7.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./IFlashLoanUser.sol";

contract FlashLoanProvider {
    mapping(address => IERC20) public tokens;

    constructor(address[] memory _tokens) {
        for (uint256 i = 0; i < _tokens.length; i++) {
            tokens[_tokens[i]] = IERC20(_tokens[i]);
        }
    }

    // function to provide the loan
    // callback -> address where to send the token, it does not have to be the contract that is receiving the money
    //amount -> amount of token to send
    //_token -> address of the token that we are sending
    // data -> arbitrary data that is forwarded to the borrower.
    function executeFlashLoan(
        address callback,
        uint256 amount,
        address _token,
        bytes memory data
    ) external {
        // pointer to the token that we are lending
        IERC20 token = tokens[_token];
        // balanace of the token in the contract before lending.
        uint256 originalBalance = token.balanceOf(address(this));
        require(address(token) != address(0), "token not supporteD");
        require(originalBalance >= amount, "amount too high");
        token.transfer(callback, amount);
        IFlashLoanUser(callback).flashLoanCallback(amount, _token, data);
        // at ths point the user must have returned the money
        require(
            token.balanceOf(address(this)) == originalBalance,
            "flashloan not reimbursed"
        );
    }
}
