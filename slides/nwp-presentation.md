---
marp: true
theme: default
paginate: true
transition: overlap
math: katex
footer: "DHSN | Vorschlag eines Systems für Laborübungen für die Ausbildung mit neuronalen Netzwerken | Anton Klüver & Rico Ukro"
---

<!-- markdownlint-disable MD001 MD004 MD009 MD012 MD013 MD019 MD022 MD024 MD026  MD032 MD033 MD036 MD041 -->

<style>
  /* Adds styling for codeblocks to add line numbers with custom engine */
  /* Based on: https://github.com/orgs/marp-team/discussions/164 */
  pre ol {
      all: unset;
      display: grid;
      grid-template-columns: auto 1fr;
      counter-reset: line-number 0;
    }
    pre ol li {
      display: contents;
    }
    pre ol li span[data-marp-line-number]::before {
      display: block;
      content: counter(line-number) " ";
      counter-increment: line-number;
      text-align: left;
      color: #bbb; /* Lighter color for line numbers */
      font-weight: lighter; /* Lighter font weight for line numbers */
    }
  /* Center all h1 elements */
  h1 {
    text-align: center;
  }
  /* Fix all h2 elements to top */
  h2 {
    position: absolute;
    top: 55px; /* 78.5px is the default theme padding of all slides */
  }
  /* Centered text */
  .centered {
    text-align: center;
  }
  /* For sources of citations */
  .source {
    font-size: 20px;
  }

  li {
    font-size: 25px;
  }
</style>

<style scoped>
  h1 {
    text-align: left;
  }
</style>

<!-- _footer: "" -->

![bg left:40% 80%](res/logo_DHSN.svg?)

# Vorschlag eines Systems für Laborübungen für die Ausbildung mit neuronalen Netzwerken

von Ranton und Ico

---

## Agenda

- Aufgabenstellung
- Idee
- Anforderungen
- Entwurf

---

## Aufgabenstellung

### Implementierung von GPU-Workload

<div style="font-size: 25px;">
Schlagen Sie ein System für Laborübungen für die Ausbildung mit neuronalen Netzwerken vor, mit folgenden Anforderungen:
</div>

- 2 Seminargruppen á 25 Studenten gleichzeitig, Jupyter
- Ressourcen pro Student
  - 16GB Arbeitsspeicher
  - 4 CPU-Cores
  - 8GB GPU-Speicher
  - 250 GB HDD / SSD
- Nutzungshorizont: 5 Jahre

---

## Idee

- Zentrale Server mit Datenhaltung und Rechenleistung
- Thin-Clients an Arbeitsplätzen
- Remotezugriff auf virtuellen Desktop

---

<style scoped>
  li {
    font-size: 25px;
  }
</style>

## Anforderungen

- Zentral wartbares und verteilbares System (Server-Client)
  - Verteilung auf zwei Server (jeweils ein Serverraum)
- Ausfallsicherheit
- Datensicherheit, Datenschutz
- Technische Anforderungen laut Lastenheft
- Virtuelle Betriebssysteme für alle Studiengänge nutzbar
- Proxyserver
  - Lastverteilung
  - Auslastung des Servers 1 auf bis zu 90%
  - Reduktion des simultanen Hardwareverschleißes
- Regelmäßige Backups (täglich, inkrementell, Backup-Server im zweiten Serverraum)

---

## Entwurf - Computeserver

- Vorgeschalteter Proxyserver
- QEMU als Hypervisor - Verwaltung Windows-VMs

### Software

- [QEMU](https://www.qemu.org/)
- [NixOS](https://nixos.org/)

### Hardware

- 10x Nvidia PNY 40GB A100 [SMB IT-Solution (17.03.2025, 11.995,95€)](https://smb-it-solution.com/de/nvidia-pny-40gb-a100-pcie-hbm2-tcsa100m-pb.html)
- 2x AMD EPYC™ 9745 [Servertronic (10.03.2025, 7.489,00€)](https://servertronic.de/index.php?subindex=1&operation=show&art=artikel&artikelnummer=1003237)
- 14x Patriot VIPER VENOM 64GB [Mindfactory (18.03.2025, 173,84€)](https://www.mindfactory.de/product_info.php/64GB-Patriot-VIPER-VENOM-DDR5-6000-DIMM-CL36-Dual-Kit_1503728.html)

---

## Entwurf - Storageserver

- Zentraler Speicher für Nutzerdaten
- SMB-Anbindung unabhängig von VM-Instanzen
- LDAP-basierte Nutzerverwaltung - Lightweight Directory Access Protocol (OpenLDAP)
- Tägliches Backup (inkrementell)

### Software

- [TrueNAS Scale](https://www.truenas.com/truenas-scale/)

### Hardware

- 2x Synology Rackstation RS422+ [Cyberport (17.03.2025, 768,40€)](https://www.cyberport.de/pc-und-zubehoer/nas-das/nas-systeme/synology/pdp/3f15-2kk/synology-rackstation-rs422-nas-system-4-bay.html#description)
- 8x WD Red Pro 4 TB [Western Digital (17.03.2025, 173,99€)](https://www.westerndigital.com/de-de/products/outlet/internal-drives/wd-red-pro-sata-hdd?sku=WD4003FFBX)

---

## Entwurf - Thin-Clients

- Kostengünstig, wartungsarm, einfach austauschbar
- Authentifizierung über LDAP

### Software

- NixOS
- [FreeRDP](https://www.freerdp.com/)

### Hardware

- 50x Mini-PC [Office-Partner (17.03.2025, 273,88€)](https://www.office-partner.de/ecs-elitegroup-95-696-mh2216-24049213)

---

## Entwurf - VM

### Software

- Windows
- Python
- Jupyter Notebook
- Office-Suite
- Und weitere nach Bedarf...

---

## Entwurf

### Ablauf Anmeldevorgang

<div class="centered">
  <img src="res/diagrams/auth-sequence-diagram.png?" alt="Sequenz Diagramm Authentifizierung" style="width: 100%;"/>
</div>

<div class="centered source">Quelle: Eigene Darstellung</div>

---

## Physische Infrastruktur – Redundanz- und Hochverfügbarkeitskonzept

| Komponente                | Serverraum 1        | Serverraum 2              |
| ------------------------- | ------------------- | ------------------------- |
| **Compute-Server**        | Primär-Server       | Sekundär-Server (Standby) |
| **Stromversorgung (USV)** | USV-Anlage 1        | USV-Anlage 2              |
| **Netzwerkanbindung**     | Netzwerkswitch 1    | Netzwerkswitch 2          |
| **Shared Storage**        | Primäres NAS-System | Backup-NAS (Replikat)     |

- Automatisches Failover
- Tägliche inkrementelle Backups

---

# Einmaliges Angebot

**Jetzt kaufen für nur 153.994,98 €**

- Exklusive: USV, Switches, Server-Racks, Verkabelung, IO, Installation, etc ...
- Inklusive: 1x Tüte Datteln

---

## Bis Baldrian...

<div class="centered">
  <!-- <img src="res/last-slide-picture.png?" alt="Tschüss" style="width: 40%;"/> -->
  <img src="res/ranton_ico.webp?" alt="Tschüss" style="width: 40%;"/>
</div>
