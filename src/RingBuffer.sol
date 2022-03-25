// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

library RingBuffer {
    /* Represents a ring buffer */
    struct RB_RingBuffer {
        bytes32[] xs;       /* elements */
        uint256 n;          /* maximum number of elements */
        uint256 read;       /* read offset (next read will occur from here) */
        uint256 write;      /* write offset (next write will occur here) */
    }

    /**
     * @notice Appends a new element to the provided ring buffer
     * @param buf Old ring buffer
     * @param x New element to append
     * @return New ring buffer with appropriate changes made
     * @dev In the case of fullness, oldest data is overwritten first
     */
    function push(
        RB_RingBuffer memory buf,
        bytes32 x
    ) public pure returns (RB_RingBuffer memory) {
        /* new fields */
        bytes32[] memory elems;
        uint256 n;
        uint256 read;
        uint256 write;

        /* handle full condition */
        if (buf.write == buf.n) {
            write = 0;
        } else {
            write = buf.write + 1;
        }

        /* copy old elements */
        elems = buf.xs;

        /* insert new element */
        elems[write] = x;

        /* other fields remain unchanged */
        n = buf.n;
        read = buf.read;

        /* construct new RingBuffer instance */
        return RB_RingBuffer(elems, n, read, write);
    } 
}

