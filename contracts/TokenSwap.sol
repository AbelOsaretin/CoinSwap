// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    address TokenA;
    address TokenB;

    mapping(address => uint256) public ATokenDeposit;

    mapping(address => uint256) public BTokenDeposit;

    constructor(address _tokenA, address _tokenB) {
        TokenA = _tokenA;
        TokenB = _tokenB;
    }

    function AddLiquidity(
        uint256 _amountTokenA,
        uint256 _amountTokenB
    ) external {
        require(
            IERC20(TokenA).transferFrom(
                msg.sender,
                address(this),
                _amountTokenA
            ),
            "Deposit Faild for TokenA"
        );
        require(
            IERC20(TokenB).transferFrom(
                msg.sender,
                address(this),
                _amountTokenB
            ),
            "Deposit Failed for TokenB"
        );
        ATokenDeposit[msg.sender] = _amountTokenA;
        BTokenDeposit[msg.sender] = _amountTokenB;
    }

    function ViewApproval() external view returns (uint256) {
        return IERC20(TokenA).allowance(msg.sender, address(this));
    }

    function SwapToken(uint256 _toAmount) external {
        require(swap(_toAmount), "Unable to Swap Token");
    }

    function swap(uint256 _value) internal returns (bool) {
        require(msg.sender != address(0x0), "Wrong EOA");

        ATokenDeposit[msg.sender] = ATokenDeposit[msg.sender] - _value;

        BTokenDeposit[msg.sender] = BTokenDeposit[msg.sender] + _value;
        //(success, _to.call{value:_value}(""));
        //_to.transfer(_value);
        // Event
        return true;
    }
}
