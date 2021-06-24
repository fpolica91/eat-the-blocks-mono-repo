// SPDX-License-Identifier: MIT
pragma solidity 0.7.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// simple token constructor only
contract OppenZeppToken1 is ERC20 {
    constructor() ERC20("OppenZeppToken1", "OP1") {}
}

// with mint function on deploy
contract OppenZeppToken2 is ERC20 {
    constructor() ERC20("OppenZeppToken2", "OP2") {
        _mint(msg.sender, 100000);
    }
}

// with external mint only callable by admin.
contract OppenZeppToken3 is ERC20 {
    address public admin;

    constructor() ERC20("OppenZeppToken3", "OP3") {
        admin = msg.sender;
    }

    function mint(address _to, uint256 _amount) external {
        require(msg.sender == admin, "only admin can mint");
        _mint(_to, _amount);
    }
}

// faucet example.

contract OppenZeppTokenFaucet is ERC20 {
    address public admin;

    constructor() ERC20("OppenZeppTokenFaucet", "FAU") {}

    function faucet(address _to, uint256 _amount) external {
        _mint(_to, _amount);
    }
}
