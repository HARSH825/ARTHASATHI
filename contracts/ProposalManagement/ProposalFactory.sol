pragma solidity ^0.5.0;

import "./ContractFeeProposal.sol";
import "./MemberProposal.sol";

contract ProposalFactory {

    function newContractFeeProposal(
        uint256 _proposedFee,
        uint16 _minimumNumberOfVotes,
        uint8 _majorityMargin
    ) external returns(address proposal) {
        proposal = address(
            new ContractFeeProposal(
                _proposedFee,
                _minimumNumberOfVotes,
                _majorityMargin,
                msg.sender
            )
        );
    }

    function newMemberProposal(
        address _memberAddress,
        bool _adding,
        uint256 _trusteeCount,
        uint8 _majorityMargin
    ) external returns (address proposal) {
        uint256 minVotes = _trusteeCount / 2;
        minVotes = minVotes == 0 ? (minVotes + 1) : minVotes;

        proposal = address(
            new MemberProposal(
                _memberAddress,
                _adding,
                minVotes,
                _majorityMargin,
                msg.sender
            )
        );
    }
}
