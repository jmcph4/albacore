// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "ds-test/test.sol";

import "../RingBuffer.sol";

contract RingBufferTest is DSTest {
    function setUp() public {}

    function testPushNormalEmpty() public {
        uint256 some_len = 12; /* arbitrary */
        bytes32 some_elem = bytes32(0);
        RingBuffer.RB_RingBuffer memory init_buf = RingBuffer.init(some_len);

        RingBuffer.RB_RingBuffer memory actual_buf = RingBuffer.push(
            init_buf,
            some_elem
        );

        bytes32[] memory expected_xs = new bytes32[](1);
        expected_xs[0] = some_elem;

        RingBuffer.RB_RingBuffer memory expected_buf = RingBuffer.RB_RingBuffer(
            expected_xs,
            some_len,
            1,
            0
        );

        assertEq(actual_buf.xs[0], expected_buf.xs[0]);
        assertEq(actual_buf.n, expected_buf.n);
        assertEq(actual_buf.read, expected_buf.read);
        assertEq(actual_buf.write, expected_buf.write);
    }
}
