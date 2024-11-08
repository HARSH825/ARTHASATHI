pragma solidity ^0.5.0;

interface RequestFactoryInterface {
    function createLendingRequest(uint256, uint256, string calldata, address payable) external returns(address);
}

interface LendingRequestInterface {
    function deposit(address payable) external payable returns(bool, bool);
    function withdraw(address) external;
    function cleanUp() external;
    function cancelRequest() external;
    function asker() external view returns(address payable);
    function withdrawnByLender() external view returns(bool);
    function getRequestParameters() external view returns(address payable, address payable, uint256, uint256, uint256, string memory);
    function getRequestState() external view returns(bool, bool, bool, bool);
}

contract RequestManagement {
    event RequestCreated();
    event RequestGranted();
    event DebtPaid();
    event Withdraw();

    mapping(address => uint256) private requestIndex;
    mapping(address => uint256) private userRequestCount;
    mapping(address => bool) private validRequest;

    address private requestFactory;
    address[] private lendingRequests;

    constructor(address _factory) public {
        requestFactory = _factory;
    }

    function ask(uint256 _amount, uint256 _paybackAmount, string memory _purpose) public {
        require(_amount > 0, "invalid amount");
        require(_paybackAmount > _amount, "invalid payback");
        require(userRequestCount[msg.sender] < 5, "too many requests");

        address request = RequestFactoryInterface(requestFactory).createLendingRequest(
            _amount,
            _paybackAmount,
            _purpose,
            msg.sender
        );

        userRequestCount[msg.sender]++;
        requestIndex[request] = lendingRequests.length;
        lendingRequests.push(request);
        validRequest[request] = true;

        emit RequestCreated();
    }

    function deposit(address payable _lendingRequest) public payable {
        require(validRequest[_lendingRequest], "invalid request");
        require(msg.value > 0, "invalid value");

        (bool lender, bool asker) = LendingRequestInterface(_lendingRequest).deposit.value(msg.value)(msg.sender);
        require(lender || asker, "Deposit failed");

        if (lender) {
            emit RequestGranted();
        } else if (asker) {
            emit DebtPaid();
        }
    }

    function withdraw(address payable _lendingRequest) public {
        require(validRequest[_lendingRequest], "invalid request");

        LendingRequestInterface(_lendingRequest).withdraw(msg.sender);

        if(LendingRequestInterface(_lendingRequest).withdrawnByLender()) {
            address payable asker = LendingRequestInterface(_lendingRequest).asker();
            LendingRequestInterface(_lendingRequest).cleanUp();
            removeRequest(_lendingRequest, asker);
        }

        emit Withdraw();
    }

    function cancelRequest(address payable _lendingRequest) public {
        require(validRequest[_lendingRequest], "invalid Request");

        LendingRequestInterface(_lendingRequest).cancelRequest();
        removeRequest(_lendingRequest, msg.sender);

        emit Withdraw();
    }

    function getRequests() public view returns(address[] memory) {
        return lendingRequests;
    }

    function getRequestParameters(address payable _lendingRequest)
        public
        view
        returns (address asker, address lender, uint256 askAmount, uint256 paybackAmount, uint256 contractFee, string memory purpose) {
        (asker, lender, askAmount, paybackAmount, contractFee, purpose) = LendingRequestInterface(_lendingRequest).getRequestParameters();
    }

    function getRequestState(address payable _lendingRequest)
        public
        view
        returns (bool verifiedAsker, bool lent, bool withdrawnByAsker, bool debtSettled) {
        return LendingRequestInterface(_lendingRequest).getRequestState();
    }

    function removeRequest(address _request, address _sender) private {
        require(validRequest[_request], "invalid request");

        userRequestCount[_sender]--;
        uint256 idx = requestIndex[_request];
        if(lendingRequests[idx] == _request) {
            requestIndex[lendingRequests[lendingRequests.length - 1]] = idx;
            lendingRequests[idx] = lendingRequests[lendingRequests.length - 1];
            lendingRequests.pop();
        }
        validRequest[_request] = false;
    }
}
