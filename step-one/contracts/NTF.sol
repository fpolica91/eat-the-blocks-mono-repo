pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NFT is ERC721 {
    constructor() ERC721("TOKEN NAME", "TOKEN SYMBOL") {}
}

contract NFT1 is ERC721 {
    constructor() ERC721("TOKEN NAME 1 ", "TOKEN SYMBOL 1") {
        _safeMint(msg.sender, 0);
    }
}

contract NF2 is ERC721 {
    address public admin;

    constructor() ERC721("TOKEN NAME 2 ", "TOKEN SYMBOL 2") {
        admin = msg.sender;
    }

    function mint(address _to, uint256 tokenID) external {
        require(msg.sender == admin, "die");
        _safeMint(_to, tokenID);
    }
}

contract NF6 is ERC721 {
    constructor() ERC721("TOKEN NAME 6 ", "TOKEN SYMBOL 6") {}

    function mint(address _to, uint256 tokenID) external {
        _safeMint(_to, tokenID);
    }
}
