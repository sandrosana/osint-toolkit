# OSINT Toolkit – Swiss Army Knife for Domain Recon

A modular, extensible, and automated **OSINT collection toolkit** designed for rapid domain reconnaissance and report generation.

## 🔍 Features

With one command, you get:

- ✅ WHOIS domain lookup
- 🌐 Subdomain discovery (via `subfinder` and `amass`)
- 🌀 Typosquatting detection (via `dnstwist`)
- ✉️ Email harvesting (via `theHarvester`)
- 🕵️‍♂️ Account footprinting (via `holehe`)
- 🌍 IP and service enumeration (via `shodan`)
- 🕸️ URL scan results (via `urlscanio`)
- 📊 Auto-generated HTML report (in dark mode)

Optional interactive CLI for single-tool usage.

---

## 🚀 Quick Installation

```bash
git clone https://github.com/sandrosana/osint-toolkit.git
cd osint-toolkit
bash install.sh
```

This script will:
- Copy all scripts and templates to `~/.osint-toolkit/`
- Add the `osint-scan` command alias to your shell config (`.zshrc` or `.bashrc`)

---

## 🧪 Usage

### Full scan on a domain

```bash
osint-scan example.com
```

The report will be saved as:
```
~/.osint-toolkit/reports/example.com-YYYY-MM-DD_HH-MM/domain_report.html
```

### Interactive mode (run individual tools)

```bash
bash ~/.osint-toolkit/scripts/osint-menu.sh
```

---

## 📂 Toolkit Structure

```
.osint-toolkit/
├── scripts/
│   ├── osint-launch.sh     # Main automation script
│   ├── osint-menu.sh       # Interactive mode
│   └── osint-report.sh     # HTML report generator
├── templates/
│   └── report_template.html
└── reports/
    └── [DOMAIN]-[TIMESTAMP]/
```

---

## ⚙️ Dependencies

You will need the following tools installed and accessible in your PATH:

| Tool           | Recommended Install                |
|----------------|-------------------------------------|
| `whois`        | `apt install whois`                |
| `subfinder`    | Preinstalled on Kali               |
| `amass`        | `apt install amass`                |
| `dnstwist`     | `pipx install dnstwist`            |
| `theHarvester` | `apt install theharvester`         |
| `holehe`       | `pipx install holehe`              |
| `shodan`       | `pipx install shodan`              |
| `urlscanio`    | `pipx install urlscanio`           |
| `jq`           | `apt install jq`                   |
| `dig`          | in `dnsutils` (`apt install dnsutils`) |

---

## 🔐 Shodan API Key Setup

```bash
shodan init YOUR_API_KEY
```

This will enable Shodan queries for discovered subdomains.

---

## 🌒 HTML Report

The report is built from a dark-mode friendly HTML template. It contains:

- WHOIS data
- All subdomains found (with count)
- DNS twisting results
- Email addresses (if any)
- Holehe account check results
- Shodan raw output for all resolvable IPs
- URLScan search result

You can open it directly in your browser.

---

## 📦 Packaging (Coming Soon)

We're working on:
- `.deb` installer
- Python wrapper with CLI parser
- Plugin system for future tool integrations (e.g. Censys, FOFA, GreyNoise)

---

## 🪪 License

MIT – use it, improve it, share it. Attribution appreciated.

---

## 👤 Author

**Sandro Sana** – [LinkedIn](https://www.linkedin.com/in/sandrosana) / [RedHotCyber](https://www.redhotcyber.com/)

---

## 💬 Feedback & Contributions

Pull requests and feature suggestions are welcome. 
Use the [Issues](https://github.com/sandrosana/osint-toolkit/issues) section to report bugs or request features.

---

Stay stealthy 🕵️ and automate your recon! 💣
