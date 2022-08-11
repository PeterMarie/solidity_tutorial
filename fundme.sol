//  SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

//import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
} 

contract FundMe {

    mapping(address=>uint) public senderaddresstoamontvalue;
    AggregatorV3Interface pricefeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

    function fund() public payable {
        senderaddresstoamontvalue[msg.sender] += msg.value;
    }

    function getVersion() public view returns(uint){
        return pricefeed.version();
    }

    function getPrice() public view returns(uint){
        (,int256 answer,,,) = pricefeed.latestRoundData();
            return uint(answer);
    }

    function getDecimals() public view returns(uint8){
        return pricefeed.decimals();
    }
}
