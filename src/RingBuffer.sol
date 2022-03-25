// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

library RingBuffer {
    /* Represents a ring buffer */
    struct RingBuffer {
        bytes32[] xs;       /* elements */
        uint256 read;       /* read offset (next read will occur from here) */
        uint256 write;      /* write offset (next write will occur here) */
    }
}

