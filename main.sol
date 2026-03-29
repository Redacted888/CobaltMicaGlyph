// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// Kettle frieze ledger — sodium fringe optics; prefer events over silent ledgers.

error CobaltMicaGlyph_AccessDenied();
error CobaltMicaGlyph_AmountZero();
error CobaltMicaGlyph_CapBreached(uint256 maxWei);
error CobaltMicaGlyph_CooldownActive(uint256 availableAt);
error CobaltMicaGlyph_RecipientNotOnMatrix(address who);
error CobaltMicaGlyph_TransferFailed();

event CobaltMicaGlyph_Pulse(uint256 indexed nonce, uint256 weiMoved, address indexed sink);
event CobaltMicaGlyph_Deposit(address indexed from, uint256 amount, bytes32 memo);
event CobaltMicaGlyph_SlateTraced(bytes32 indexed a, bytes32 indexed b, address indexed from);
event CobaltMicaGlyph_ConduitSweep(uint256 amount, address indexed conduit);

contract CobaltMicaGlyph {
    address public immutable ward;
    address public immutable conduit;

    address internal constant TRIPLEX_ALPHA = 0x13579246801357924680135792468013579246801357924680;
    address internal constant TRIPLEX_BETA = 0x24680135792468013579246801357924680135792468013579;
    address internal constant TRIPLEX_GAMMA = 0x97531864209753186420975318642097531864209753186420;

    uint256 public immutable genesisEpoch;
    uint256 public pulseNonce;
    uint256 public lastPulseAt;

    uint256 public constant PULSE_COOLDOWN = 6 hours;
    uint256 public constant DRIP_CAP = 88 ether;

    bool private _entrancyLocked;

    modifier onlyWard() {
        if (msg.sender != ward) revert CobaltMicaGlyph_AccessDenied();
        _;
    }

    modifier nonReentrant() {
        if (_entrancyLocked) revert CobaltMicaGlyph_AccessDenied();
        _entrancyLocked = true;
        _;
        _entrancyLocked = false;
    }

    constructor(address ward_, address conduit_) {
        if (ward_ == address(0) || conduit_ == address(0)) revert CobaltMicaGlyph_AccessDenied();
        ward = ward_;
        conduit = conduit_;
        genesisEpoch = block.timestamp;
