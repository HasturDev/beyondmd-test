#!/usr/bin/env bats

# Test Docker installation
@test "Docker is installed" {
    run docker --version
    [ "$status" -eq 0 ]
}

# Test npm installation
@test "npm is installed" {
    run npm --version
    [ "$status" -eq 0 ]
}

# Test Vagrant installation
@test "Vagrant is installed" {
    run vagrant version
    [ "$status" -eq 0 ]
}

# Test VirtualBox installation
@test "VirtualBox is installed" {
    run VBoxManage --version
    [ "$status" -eq 0 ]
}

# Test Node.js installation
@test "Node.js is installed" {
    run node --version
    [ "$status" -eq 0 ]
}