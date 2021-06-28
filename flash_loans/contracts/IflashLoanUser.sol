pragma solidity 0.7.3;

interface IFlashLoanUser {
    function flashLoanCallback(
        uint256 amount,
        address token,
        bytes memory data
    ) external;
}
