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
            0,
            1
        );

        assertEq(actual_buf.xs[0], expected_buf.xs[0]);
        assertEq(actual_buf.n, expected_buf.n);
        assertEq(actual_buf.read, expected_buf.read);
        assertEq(actual_buf.write, expected_buf.write);
    }

    function testPushNormalFull() public {
        uint256 some_len = 3; /* arbitrary */
        bytes32[] memory some_elems = new bytes32[](some_len);
        some_elems[0] = bytes32(uint256(1));
        some_elems[1] = bytes32(uint256(2));
        some_elems[2] = bytes32(uint256(3));
        bytes32 some_extra_elem = bytes32(uint256(12));

        RingBuffer.RB_RingBuffer memory init_buf = RingBuffer.RB_RingBuffer(
            some_elems,
            some_len,
            0,
            3
        );

        RingBuffer.RB_RingBuffer memory actual_buf = RingBuffer.push(
            init_buf,
            some_extra_elem
        );

        bytes32[] memory expected_xs = new bytes32[](some_len);
        expected_xs[0] = some_extra_elem;
        expected_xs[1] = some_elems[1];
        expected_xs[2] = some_elems[2];

        RingBuffer.RB_RingBuffer memory expected_buf = RingBuffer.RB_RingBuffer(
            expected_xs,
            some_len,
            0,
            1
        );

        assertEq(actual_buf.xs[0], expected_buf.xs[0]);
        assertEq(actual_buf.xs[1], expected_buf.xs[1]);
        assertEq(actual_buf.xs[2], expected_buf.xs[2]);
        assertEq(actual_buf.n, expected_buf.n);
        assertEq(actual_buf.read, expected_buf.read);
        assertEq(actual_buf.write, expected_buf.write);
    }
}
