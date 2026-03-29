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

