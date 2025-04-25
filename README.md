# 🌾 FarmChain

**FarmChain** is a fully on-chain farming simulation game built with Solidity.  
No tokens, no NFTs, no pay-to-play. Just simple blockchain fun.  
Every wallet is a farmer. Plant crops. Wait. Harvest. Repeat.

---

## 🧑‍🌾 How It Works

- Each wallet has its own virtual farm.
- You can plant either **Wheat** or **Corn**.
- Crops grow over time (default: 1 day).
- After the time passes, you can **harvest** your crop.
- One crop at a time — patience is part of farming 😌

---

## 🚜 Features

- ✅ No land to buy — farming is free for everyone
- 🌱 On-chain crop growth timer
- ⏳ `timeLeft()` to check how long until harvest
- 🌽 Events for planting and harvesting
- 📦 Minimal, gas-efficient logic

---

## 💻 Contract Overview

```solidity
enum CropType { None, Wheat, Corn }

struct Crop {
    CropType cropType;
    uint plantedAt;
}

mapping(address => Crop) public crops;
