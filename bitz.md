```markdown
# ⚡ Blitz Collector - Mining on Solana

Farm $BITZ efficiently using your GPU/CPU on a Solana-based network. This guide helps you install all dependencies, configure your wallet, set up RPC, and start farming with Blitz.

> 💡 Recommended: Use Ubuntu 20.04/22.04 VPS with root access
```

---

## 🧰 Prerequisites

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl screen nano build-essential pkg-config libssl-dev libudev-dev -y
```

---

## 🦀 Install Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

---

## 🔧 Install Solana CLI

```bash
sh -c "$(curl -sSfL https://release.anza.xyz/v1.18.11/install)"
echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### ✅ Check Version

```bash
solana --version
```

---

## 🌐 Set RPC Endpoint

```bash
solana config set --url https://eclipse.helius-rpc.com
```

---

## 🔐 Wallet Setup

### ➕ To Generate New Wallet

```bash
solana-keygen new
solana address
cat ~/.config/solana/id.json  # Save this backup securely
```

### 🔁 To Restore Wallet from Backup

```bash
mkdir -p ~/.config/solana
nano ~/.config/solana/id.json   # Paste your JSON private key here
chmod 600 ~/.config/solana/id.json
```

---

## 🔍 Check How Many CPU Cores You Have

```bash
nproc
```

> Output will show number of available cores (e.g., `6` or `8`). Use this in the next step to assign cores.

---

## ⚡ Install Blitz Miner

```bash
cargo install bitz
```

---

## 🖥️ Start Collecting BITZ

```bash
screen -S bitz
bitz collect
```

### ➕ To Use Specific CPU Cores

```bash
bitz collect --cores 6
```

> Replace `6` with the number of cores you want to allocate.

---

## 💡 Tips

- Use a **custom RPC** for better performance (e.g., Helius, Triton).
- Monitor logs and scores in real-time.
- Make sure your wallet has enough SOL for transactions.
- VPS with GPU is **required**.

---

## 🛑 Stop Collection

To reattach and stop:
```bash
screen -r bitz
Ctrl + C
```

---

## 📬 Contact

If you need help or want to join the farming group, check the guide link in the bio or contact me directly.

---

## 📢 Disclaimer

This setup is for educational and research purposes. Use it responsibly and follow the network’s fair-use policy.
```

Let me know if you want this saved as a file or want to include an auto-start script as well!
