// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

interface CTokenInterface {
    function mint(uint256 amountToMint) external returns (uint256);

    function redeem(uint256 redeemTokens) external returns (uint256);

    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);

    function borrow(uint256 borrowAmount) external returns (uint256);

    function repayBorrowed(uint256 repayAmount) external returns (uint256);

    function underlying() external view returns (address);
}
