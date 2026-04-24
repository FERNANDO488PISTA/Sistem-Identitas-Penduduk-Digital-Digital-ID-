// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalID {

    struct Identity {
        string nik;
        string nama;
    }

    // address → data lengkap (auto getter)
    mapping(address => Identity) public identities;

    // NIK → nama
    mapping(string => string) public nikToName;

    // nama → NIK
    mapping(string => string) public nameToNik;

    // 📝 REGISTER
    function register(address user, string memory nik, string memory nama) public {
        identities[user] = Identity(nik, nama);

        nikToName[nik] = nama;
        nameToNik[nama] = nik;
    }

    // ✅ VERIFY
    function verify(address user, string memory nik, string memory nama) public view returns (bool) {
        return keccak256(abi.encodePacked(nik, nama)) ==
               keccak256(abi.encodePacked(identities[user].nik, identities[user].nama));
    }

    // 🔍 CEK TERDAFTAR
    function isRegistered(address user) public view returns (bool) {
        return bytes(identities[user].nik).length != 0;
    }
}