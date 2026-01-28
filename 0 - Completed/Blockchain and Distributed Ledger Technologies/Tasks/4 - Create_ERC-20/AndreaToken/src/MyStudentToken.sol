// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;    // Da questa versione in poi il codice fa revert automatico su over/underflow

contract SimpleERC20 {
    // === METADATI ===
    string public name;
    string public symbol;
    uint8 public decimals = 18;

    uint256 public totalSupply;  // Fa da check sulla validità logica del token (i.e. se sbaglio ad aggiornarlo diventa "falso")

    // === STATO === (Tabelle hash che servono a definire stato economico e di delega
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    address public owner;

    // === EVENTI STANDARD ERC-20 === (log delle transazioni)
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // === EVENTI EXTRA ===
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    // === MODIFIER ===
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // === COSTRUTTORE === (invocato solo al deploy)
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender; // "chi deploya è il proprietario"

        _mint(owner, initialSupply);
    }

    // === FUNZIONI ERC-20 ===

    // Legge il saldo dall'esterno
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    // Versione pubblica di _transfer (privata)
    function transfer(address to, uint256 value) external returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    // Espone la disponibilità di token
    function allowance(address _owner, address spender) external view returns (uint256) {
        return allowances[_owner][spender];
    }

    // Anche se è presente una disponibilità di token, l'owner può imporre un limite di transfer più basso per spender
    function approve(address spender, uint256 value) external returns (bool) {
        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // Controlla che allowance sia sufficiente, quindi esegue il transfer
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        uint256 allowed = allowances[from][msg.sender];
        require(allowed >= value, "Allowance exceeded");

        allowances[from][msg.sender] = allowed - value;
        _transfer(from, to, value);
        return true;
    }

    // === FUNZIONI EXTRA ===

    // Consente mint solo all'owner
    function mint(address to, uint256 value) external onlyOwner {
        _mint(to, value);
    }

    // Chiunque può distruggere i propri token
    function burn(uint256 value) external {
        require(balances[msg.sender] >= value, "Not enough balance");
        balances[msg.sender] -= value;
        totalSupply -= value;

        emit Burn(msg.sender, value);
        emit Transfer(msg.sender, address(0), value);
    }

    // === INTERNAL ===

    // La funzione che implementa davvero la logica di transfer
    function _transfer(address from, address to, uint256 value) internal {
        require(to != address(0), "Zero address");
        require(balances[from] >= value, "Insufficient balance");

        balances[from] -= value;
        balances[to] += value;

        emit Transfer(from, to, value);
    }

    // La funzione che implementa davvero la logica di minting
    function _mint(address to, uint256 value) internal {
        require(to != address(0), "Zero address");

        balances[to] += value;
        totalSupply += value;

        emit Mint(to, value);
        emit Transfer(address(0), to, value);
    }
}
