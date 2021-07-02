pragma solidity ^0.7.3;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
    NOTE 
    Decentralized autonomous organizations or DAO
    dApps tend to give governance tokens to stake holders,
    which are used to vote in the evolution of the defi protocol
    the way this is done is by depositing governance tokens into
    the DAO. Votes are accounted based on the tokens deposited into the DAO
 */

contract DAO {
    /**
        ANCHOR side represents the vote 
     */

    enum Side {
        Yes,
        No
    }

    /**
         ANCHOR 
         status of the proposal approved or not,
         every new proposal will have an undecided status
     */
    enum Status {
        Undecided,
        Approved,
        Rejected
    }
    struct Proposal {
        address author;
        bytes32 hash;
        uint256 createdAt;
        uint256 votesYes;
        uint256 votesNo;
        Status status;
    }
    mapping(bytes32 => Proposal) public proposals;
    /**
        ANCHOR
             address is the address of the investor,
             bytes is the hash of the proposal,
             this identifies if an investor has already voted for a proposal
             example address[1][proposal2]
     */
    mapping(address => mapping(bytes32 => bool)) public votes;
    mapping(address => uint256) shares;
    uint256 public totalShares;
    IERC20 public token;
    /**
        raising to the **18 power because eth has 18 decimal places
     */
    uint256 constant CREATE_PROPOSAL_MIN_SHARE = 100 * 10**18;
    uint256 constant VOTING_PERIOD = 7 days;

    constructor(uint256 _token) {
        token = IERC20(_token);
    }

    function deposit(uint256 amount) external {
        shares[msg.sender] += amount;
        totalShares += amount;
        token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 amount) external {
        require(shares[msg.sender] >= amount, "insufficient funds");
        shares[msg.sender] -= amount;
        totalShares -= amount;
        token.transfer(msg.sender, amount);
    }

    function createProposal(bytes32 proposalHash) external {
        require(
            shares[msg.sender] >= CREATE_PROPOSAL_MIN_SHARE,
            "not enough shares to create a proposal"
        );
        require(
            proposals[proposalHash].hash == bytes32(0),
            "this proposal already exists"
        );
        proposals[proposalHash] = Proposal(
            msg.sender,
            proposalHash,
            block.timestamp,
            0,
            0,
            Status.Undecided
        );
    }

    function vote(bytes32 proposalHash, Side side) external {
        Proposal storage proposal = proposals[proposalHash];
        require(votes[msg.sender][proposalHash] == false, "already voted");
        require(
            proposals[proposalHash].hash != bytes32(0),
            "proposal does not exist"
        );
        require(
            block.timestamp <= proposal.createdAt + VOTING_PERIOD,
            "voting period over"
        );
        votes[msg.sender][proposalHash] = true;
        if (side == Side.Yes) {
            /**NOTE
                as you can see below, the vote is weighted based on the deposited tokens
             */
            proposal.votesYes += shares[msg.sender];
            /**
                NOTE we multiple by 100 because solidity does not handle decimals.
                you can see here that we divide the number of votesYes, in other words
                tokens delegated towards approving the contract, divided over the entire amount
                of governance tokens deposited in the DAO contract.
             */
            if ((proposal.votesYes * 100) / totalShares > 50) {
                proposal.status = Status.Approved;
            }
        } else {
            proposal.votesNo += shares[msg.sender];
            if ((proposal.votesNo * 100) / totalShares > 50) {
                proposal.status = Status.Rejected;
            }
        }
    }
}
