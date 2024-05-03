// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicVotingSystem {
    struct Voter {
        bool voted;
        uint256 vote;
    }

    mapping(address => Voter) public voters;
    mapping(uint256 => uint256) public voteCount;

    uint256 public totalVotes;
    uint256 public totalCandidates;

    event Voted(address indexed voter, uint256 candidate);

    constructor(uint256 _totalCandidates) {
        totalCandidates = _totalCandidates;
    }

    function vote(uint256 _candidate) public {
        require(_candidate > 0 && _candidate <= totalCandidates, "Invalid candidate");
        require(!voters[msg.sender].voted, "Already voted");

        voters[msg.sender].voted = true;
        voters[msg.sender].vote = _candidate;

        voteCount[_candidate]++;
        totalVotes++;

        emit Voted(msg.sender, _candidate);
    }

    function getVoteCount(uint256 _candidate) public view returns (uint256) {
        require(_candidate > 0 && _candidate <= totalCandidates, "Invalid candidate");
        return voteCount[_candidate];
    }

    function getTotalVotes() public view returns (uint256) {
        return totalVotes;
    }
}