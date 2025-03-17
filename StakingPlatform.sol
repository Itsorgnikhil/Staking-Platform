// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract StakingPlatform {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // Example reward rate

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
        rewards[msg.sender] += (msg.value * rewardRate) / 1000;
    }

    function withdraw() external {
        uint256 stakedAmount = stakes[msg.sender];
        uint256 rewardAmount = rewards[msg.sender];
        require(stakedAmount > 0, "No stake to withdraw");

        stakes[msg.sender] = 0;
        rewards[msg.sender] = 0;

        payable(msg.sender).transfer(stakedAmount + rewardAmount);
    }

    function checkReward(address user) external view returns (uint256) {
        return rewards[user];
    }
} 
