pragma solidity 0.4.11;
import "Oracles/AbstractOracle.sol";


/// @title Difficulty oracle contract - Oracle to resolve difficulty events at given block
/// @author Stefan George - <stefan@gnosis.pm>
contract DifficultyOracle is Oracle {

    /*
     *  Storage
     */
    uint public blockNumber;
    int public outcome;

    /*
     *  Public functions
     */
    /// @dev Contract constructor validates and sets target block number
    /// @param _blockNumber Target block number
    function DifficultyOracle(uint _blockNumber)
        public
    {
        // Block has to be in the future
        require(_blockNumber > block.number);
        blockNumber = _blockNumber;
    }

    /// @dev Sets difficulty as winning outcome for specified block
    function setOutcome()
        public
    {
        // Block number was reached and outcome was not set yet
        require(block.number >= blockNumber && outcome == 0);
        outcome = int(block.difficulty);
    }

    /// @dev Returns if difficulty is set
    /// @return Is outcome set?
    function isOutcomeSet()
        public
        constant
        returns (bool)
    {
        // Difficulty is always bigger than 0
        return outcome > 0;
    }

    /// @dev Returns difficulty
    /// @return Outcome
    function getOutcome()
        public
        constant
        returns (int)
    {
        return outcome;
    }
}