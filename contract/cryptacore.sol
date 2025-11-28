// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Project {
    string public projectName;
    address public owner;

    // Track balances per user
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    constructor(string memory _projectName) {
        projectName = _projectName;
        owner = msg.sender;
    }

    /// @notice Allows users to deposit ETH into the project
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH to deposit");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    /// @notice Allows users to withdraw their deposited ETH
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    /// @notice Returns a user's current ETH balance stored in the contract
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}

