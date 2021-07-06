pragma solidity ^0.7.3;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/CTokenInterface.sol";
import "./interfaces/ComptrollerInterface.sol";
import "./interfaces/PriceOracleInterface.sol";

contract MyDefiProject {
    ComptrollerInterface public comptroller;
    PriceOracleInterface public priceOracle;

    constructor(address _comptroller, address _priceOracle) {
        comptroller = ComptrollerInterface(_comptroller);
        priceOracle = PriceOracleInterface(_priceOracle);
    }

    function supply(address cTokenAddress, uint256 underlyingAmount) public {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint256 result = cToken.mint(underlyingAmount);
        require(
            result == 0,
            "cToken#mint() failed. see Compound ErrorReporter.sol for details"
        );
    }
}
