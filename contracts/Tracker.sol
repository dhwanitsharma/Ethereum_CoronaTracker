pragma solidity ^0.5.0;

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
        string sector;
    }
    
    event CheckinCreated(
        uint256 aadharNo,
        string name,
        string addr,
        string CurrStatusOfSector,
        uint256 timestamp,
        string temp,
        string sector
    );
    
    event CounterUpdated(
        uint256 aadharNo,
        uint256[] index
    );
    
    constructor() public{
        owner = msg.sender;
        checkins[0] = Checkin(12345, "Test1","Test","Green",block.timestamp,"98.6","5");
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
    
    function getAadharInfo(uint256 _aadharNo) public onlyOwner view returns (uint256[] memory) {
     Identification memory _identification = Identifications[_aadharNo];
     uint256[] memory arr = _identification.index;
     return arr;
    }
    
    function getCheckinInfo(uint256 index) public onlyOwner view returns (uint256,string memory,string memory,string memory,uint256,string memory,string memory) {
        Checkin storage _checkin = checkins[index];
        uint256 _aadharNo = _checkin.aadharNo;
        string memory _name = _checkin.name;
        string memory _addr = _checkin.addr;
        string memory _StatOfSec =_checkin.CurrStatusOfSector;
        uint256 _time = _checkin.timestamp;
        string memory _temp =  _checkin.temp;
        string memory _sector = _checkin.sector;
        //return(_aadharNo);
        return (_aadharNo,_name,_addr,_StatOfSec,_time,_temp,_sector);
    }
   
    function CreateCheckin(uint256 _aadharNo,string memory _name,string memory _addr,string memory _status,string memory _temp,string memory _sector) public onlyOwner{
        CheckinCounter++;
        uint _timestamp = block.timestamp;
        checkins[CheckinCounter] = Checkin(_aadharNo, _name,_addr,_status,_timestamp,_temp,_sector);
        UpdateCounter(_aadharNo);
        emit CheckinCreated (_aadharNo, _name,_addr,_status,_timestamp,_temp,_sector);
    }
    
    
}