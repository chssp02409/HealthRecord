pragma solidity ^0.4.0;

contract Patient{
    
    struct Patient{
        address digitalId; 
        string name;
        uint age;
        string bloodGroup;
        string contactNo;
        string addressDetails;
        string geneticProblems;
        bytes32 []recordPointerAddress;
    }

    mapping (address=>Patient) public patient;

    
    function addPatient(address Id, string name, uint age, string bloodgroup, string geneticProblems, string contactNo, string addressDetails) payable returns (bool success) {
        patient[Id].name=name;
        patient[Id].age=age;
        patient[Id].bloodGroup=bloodgroup;
        patient[Id].geneticProblems=geneticProblems;
        patient[Id].contactNo=contactNo;
        patient[Id].addressDetails=addressDetails;
        success = true;
    }
    
    function getPatient(address Id) constant returns (string _name, uint _age, string _bloodgroup, string _geneticProblems, string _contactNo, string _addressDetails) {
            _name = patient[Id].name;
            _age = patient[Id].age;
            _bloodgroup = patient[Id].bloodGroup;
            _geneticProblems = patient[Id].geneticProblems;
            _contactNo = patient[Id].contactNo;
            _addressDetails = patient[Id].addressDetails;
    }
    
    struct MedRecord{
        bytes32 recordPointerAddress;
        string labName;
        string labAddress;
        string illness;
        string documentHash; 
    }
    
    // bytes32 mapped to MedRecord struct
    mapping (bytes32=>MedRecord) public medRecords;
    
    function getMedicalRecord(address Id) constant returns (bytes32[]) {
        bytes32 []uniqueRecords;
        if(msg.sender == Id){
            uniqueRecords = patient[Id].recordPointerAddress;
        }
        return uniqueRecords;
    }
    
    function getMedicalRecordDetails(bytes32 adddress) constant returns (string _labName,string _labAddress,string _illness,string _docHash) {
            _labName = medRecords[adddress].labName;
            _labAddress = medRecords[adddress].labAddress;
            _illness = medRecords[adddress].illness;
            _docHash = medRecords[adddress].documentHash;
    }
    

    function addMedicalRecords(address Id,bytes32 addr,string labName,string labAddress,string illness,string documentHash) returns (bool _success){
       medRecords[addr].labAddress=labAddress;
       medRecords[addr].illness=illness;
       medRecords[addr].documentHash=documentHash;
       patient[Id].recordPointerAddress.push(addr);
       return true;
    }
    
    
}
