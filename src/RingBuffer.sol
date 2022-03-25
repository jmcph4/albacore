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
     * @notice Initialises a new ring buffer instance
     * @param length Maximum length of the new ring buffer
     * @return Ring buffer of specified maximum length
     */
    function init(uint256 length) public pure returns (RB_RingBuffer memory) {
        return RB_RingBuffer(new bytes32[](length), length, 0, 0);
    }

    /**
     * @notice Appends a new element to the provided ring buffer
     * @param buf Old ring buffer
     * @param x New element to append
     * @return New ring buffer with appropriate changes made
     * @dev In the case of fullness, oldest data is overwritten first
     * @dev Time complexity of `O(1)`
     * @dev Time complexity of `O(n)` (due to array copy)
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

        /* copy old elements */
        elems = buf.xs;

        /* handle full condition */
        if (buf.write == buf.n) {
            write = 1;

            /* insert new element */
            elems[0] = x;
        } else {
            write = buf.write + 1;

            /* insert new element */
            elems[write] = x;
        }

        /* other fields remain unchanged */
        n = buf.n;
        read = buf.read;

        /* construct new RingBuffer instance */
        return RB_RingBuffer(elems, n, read, write);
    } 

    /**
     * @notice Retrieves the oldest element from the ring buffer and removes it
     * @param buf Ring buffer to read from
     * @return New ring buffer and (previously) oldest element
     * @dev Reverts if the ring buffer is exhausted
     * @dev Time complexity of `O(1)`
     * @dev Space complexity of `O(n)` (due to array copy)
     */
    function pop(
        RB_RingBuffer memory buf
    ) public pure returns (
        RB_RingBuffer memory,
        bytes32
    ) {
        /* new fields */
        bytes32[] memory elems;
        uint256 n;
        uint256 read;
        uint256 write;

        if (buf.read == buf.write) { /* handle empty buffer */
            revert();
        } else {
            elems = buf.xs;
            n = buf.n;
            read = buf.read + 1;
            write = buf.write;
        }

        return (RB_RingBuffer(elems, n, read, write), buf.xs[read - 1]);
    }
}

