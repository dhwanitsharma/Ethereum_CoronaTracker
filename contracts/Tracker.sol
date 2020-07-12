pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Tracker{
    
    uint256 private CheckinCounter = 0;
    
    mapping (uint256 => Identification)  private Identifications;
    
    mapping (uint256 => Checkin) private checkins;
    
    address private owner;
    
    struct Identification{
        uint256 aadharNo;
        uint256[] index;
    }
    
    struct Checkin{
        uint256 aadharNo;
        string name;
        string addr;
        string CurrStatusOfSector;
        uint256 timestamp;
        string temp;
    }
    
    event CheckinCreated(
        uint256 aadharNo,
        string name,
        string addr,
        string CurrStatusOfSector,
        uint256 timestamp,
        string temp
    );
    
    event CounterUpdated(
        uint256 aadharNo,
        uint256[] index
    );
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function UpdateCounter(uint256 _aadharNo) private{
        Identification storage _identification = Identifications[_aadharNo];
        uint256[] storage _arr  =_identification.index;
        _arr.push(CheckinCounter);
        Identifications[_aadharNo] = Identification(_aadharNo,_arr);
        emit CounterUpdated (_aadharNo,_arr);
    }
    
    function getAadharInfo(uint256 counter) public onlyOwner view returns (Identification memory) {
    return Identifications[counter];
}
    
    function getCheckinInfo(uint256 index) public onlyOwner view returns (Checkin memory) {
        return checkins[index];
    }    
   
    function CreateCheckin(uint256 _aadharNo,string memory _name,string memory _addr,string memory _status,string memory _temp) public onlyOwner{
        CheckinCounter++;
        uint _timestamp = block.timestamp;
        checkins[CheckinCounter] = Checkin(_aadharNo, _name,_addr,_status,_timestamp,_temp);
        UpdateCounter(_aadharNo);
        emit CheckinCreated (_aadharNo, _name,_addr,_status,_timestamp,_temp);
    }
    
    
}