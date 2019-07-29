pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/lifecycle/Pausable.sol';

contract Poe is Ownable, Pausable {

  //The struct containing the file details
  struct IpfsData {
    string name;
    string hashLink;
    string tags;
    uint timestamp;
    string dataExt;
  }

  //This will be fired when a new file is added
  event newData(
                  address indexed dataOwner,
                  string name,
                  string hashLink,
                  string tags,
                  uint timestamp,
                  string _dataExt
                );

  IpfsData[] public ipfsData;
  mapping (address => uint[]) private ownerIndexes;
  mapping (uint => address) public dataOwner;

  /**
  * @dev Get owner data indexes
  * @return Array uint ownerIndexes
  */
  function getIndexes() public view returns (uint[] memory) {
    return ownerIndexes[msg.sender];
  }

  /**
  * @dev The owner get file info by the index
  * @return name, hashLink, tags, timestamp, dataExt
  */
  function getData(uint _index) public view returns (string memory, string memory, string memory, uint, string memory) {
    require(msg.sender == dataOwner[_index]);
    return (
      ipfsData[_index].name,
      ipfsData[_index].hashLink,
      ipfsData[_index].tags,
      ipfsData[_index].timestamp,
      ipfsData[_index].dataExt
      );
  }

  /**
   * @dev Check text length
   */
  modifier isTextLengthOk(string memory _name, string memory _hashLink, string memory _tags, string memory _dataExt) {
    require(bytes(_hashLink).length <= 46);
    require(bytes(_tags).length <= 60);
    require(bytes(_name).length <= 60);
    require(bytes(_dataExt).length <= 4);
    _;
  }

  /**
  * @dev Add data
  * @param _name Name of the file
  * @param _hashLink Hash of IPFS file
  * @param _tags concatenate tags string
  * @param _dataExt File extension string
  */
  function setData(string memory _name, string memory _hashLink, string memory _tags, string memory _dataExt)
    public
    whenNotPaused
    isTextLengthOk(_name,_hashLink,_tags, _dataExt)
  {
    uint id = ipfsData.push(IpfsData(_name, _hashLink, _tags, now, _dataExt)) - 1;
    ownerIndexes[msg.sender].push(id);
    dataOwner[id] = msg.sender;
    emit newData(msg.sender, _name, _hashLink, _tags, now, _dataExt);
  }



}
