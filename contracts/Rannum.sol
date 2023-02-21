// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";


contract RANNUM is VRFConsumerBaseV2{

    uint64 subId;
    address vrfCoordinator;
    bytes32 keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
    uint32 callbackGasLimit = 100000;
    uint16 requestConfirmations = 1;
    uint32 numWords =  1;


    mapping(uint => uint256[]) ReqstsRes;
    uint[] ReqIDs;





    constructor (uint64 _subId, address _vrfcordinator) VRFConsumerBaseV2(_vrfcordinator){
        subId = _subId;
        vrfCoordinator = _vrfcordinator;
    }

    


    function getReqID() public returns(uint requestId){
        requestId = VRFCoordinatorV2Interface(vrfCoordinator).requestRandomWords(
            keyHash,
            subId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        ReqIDs.push(requestId);
    }


    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal virtual override{
        ReqstsRes[requestId] = randomWords;
    }

    function getRandomNum() public view returns (uint256[] memory _number){
        uint latestReqID = ReqIDs[ReqIDs.length -1];
        _number = ReqstsRes[latestReqID];
    }
}