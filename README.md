# 📘 Terraform Multi-Cloud DR Infrastructure - README

Questo progetto utilizza Terraform per creare un'infrastruttura di Disaster Recovery (DR) distribuita su AWS (primario) e Google Cloud (secondario), con supporto per Load Balancer, Database, Storage, Networking e Failover DNS tramite Route53. 

## 📦 Contenuto del Progetto

- Moduli AWS:
  - Compute (EC2)
  - Networking (VPC, Subnet, IGW)
  - Database (RDS MySQL)
  - Load Balancer (ALB)
  - Storage (S3)
- Moduli Google Cloud:
  - Compute (GCE)
  - Networking (VPC, Subnet)
  - Database (Cloud SQL)
  - Load Balancer (HTTP LB)
  - Storage (GCS)
- Failover DNS:
  - Route53 configurato con health check e record primario/secondario
- Analisi dei costi:
  - Infracost

---

## 🛠️ Comandi Terraform Utili

### 1. Inizializzazione
```bash
terraform init
```
Inizializza la directory di lavoro con i provider e moduli.

### 2. Validazione della Configurazione
```bash
terraform validate
```
Controlla che la sintassi e le risorse siano corrette.

### 3. Pianificazione delle Risorse
```bash
terraform plan
```
Mostra un piano dettagliato delle modifiche che verranno apportate.

### 4. Applicazione delle Modifiche
```bash
terraform apply
```
Applica il piano Terraform, creando/modificando/distruggendo le risorse.

### 5. Visualizzazione dello Stato Attuale
```bash
terraform show
```
Visualizza lo stato attuale dell'infrastruttura.

### 6. Pulizia dell'infrastruttura
```bash
terraform destroy
```
Rimuove tutte le risorse definite nel progetto.

---

## 💰 Comandi Infracost

### 1. Breakdown dei Costi
```bash
infracost breakdown --config-file infracost.yml --show-skipped
```
Mostra la stima mensile dei costi di tutte le risorse definite nei moduli.

### 2. Output in HTML (report visuale)
```bash
infracost breakdown --config-file infracost.yml --format html --out-file infracost-report.html
```

### 3. Output in JSON (per CI/CD o integrazione automatica)
```bash
infracost breakdown --config-file infracost.yml --format json --out-file infracost.json
```

---

## 🧩 Best Practice

- Eseguire `terraform validate` ad ogni modifica.
- Utilizzare `terraform plan` prima di ogni `apply`.
- Eseguire `infracost` prima di approvare modifiche per capire l'impatto economico.
- Versionare `terraform.lock.hcl` per garantire consistenza tra ambienti.

---

## 📎 File Principali

- `main.tf` → invoca tutti i moduli (AWS e GCP)
- `providers.tf` → definisce provider AWS e Google
- `variables.tf` → variabili condivise
- `infracost.yml` → configurazione dei moduli da analizzare con Infracost
- `outputs.tf` → mostra i riferimenti utili a risorse chiave (IP, DNS, ecc.)

## Variabili Principali

- **`route53_health_check_type`**: `"HTTPS"`  
  Tipo di health check eseguito. Supporta: HTTP, HTTPS, TCP.

- **`route53_health_check_port`**: `443`  
  Porta sulla quale viene effettuato il controllo di salute.

- **`route53_health_check_path`**: `"/"`  
  Percorso interrogato in caso di check HTTP/HTTPS. Ignorato per TCP.

- **`route53_health_check_interval`**: `30`  
  Frequenza (in secondi) con cui Route 53 effettua il controllo.

- **`route53_health_check_failure_threshold`**: `3`  
  Numero di fallimenti consecutivi prima di considerare l'istanza "down".

- **`route53_ttl`**: `60`  
  TTL (Time To Live) per i record DNS primario e secondario.