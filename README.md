# Blockchain-Based Land Registry & Property Ownership System

## 📌 Project Overview

The Blockchain-Based Land Registry & Property Ownership System is an educational blockchain prototype developed using Solidity smart contracts.

The project demonstrates how blockchain technology can be used to simulate:

- Property registration
- Property ownership records
- Property verification
- Ownership transfer
- Ownership history
- Property status
- Access control
- Transaction logging

This project uses only synthetic property data and Remix VM test accounts.

> **Disclaimer:** This is an educational prototype. It does not create, transfer, or establish legally valid property ownership and is not connected to any government land registry.

---

## 🎯 Objectives

The main objectives of this project are:

1. Store property records using a Solidity smart contract.
2. Maintain the current property owner.
3. Allow authorized verification of properties.
4. Allow the current owner to transfer ownership.
5. Preserve previous ownership records.
6. Prevent unauthorized users from performing restricted operations.
7. Demonstrate blockchain-based transaction records.

---

## 🛠️ Technology Stack

- Solidity
- Ethereum Smart Contracts
- Remix IDE
- Remix VM
- Web3 / Blockchain Concepts
- GitHub

---

## ⚙️ Main Features

### 1. Property Registration

The registrar can register a new property with:

- Property ID
- Location
- Area
- Property Type
- Owner Address

### 2. Property Verification

Only the authorized registrar can verify a property.

### 3. Ownership Transfer

Only the current property owner can transfer ownership to another wallet.

### 4. Ownership History

Previous owner and new owner information is stored along with a blockchain timestamp.

### 5. Access Control

Registrar-only functions are protected using Solidity modifiers.

### 6. Property Validation

The smart contract checks whether a property exists before performing operations.

---

## 🏗️ System Workflow

```text
User
 |
 v
Remix Interface
 |
 
LandRegistry Smart Contract
 |
 +---- Register Property
 |
 +---- Verify Property
 |
 +---- Transfer Ownership
 |
 +---- Store Ownership History
 |
 v
Blockchain / Remix VM
