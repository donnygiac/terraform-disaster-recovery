# 📘 Terraform Multi-Cloud Infrastructure – Service Continuity con AWS e GCP

Questo progetto implementa un'infrastruttura multi-cloud orientata alla continuità del servizio (Service Continuity) utilizzando Terraform come motore di provisioning. L’ambiente prevede una configurazione attiva su AWS (primario) e una secondaria su Google Cloud Platform (GCP), con gestione del failover automatico tramite Route 53 e analisi dei costi tramite Infracost.

Non vengono utilizzati Load Balancer: le VM espongono direttamente i servizi HTTPS mediante certificati SSL generati localmente (es. Certbot).

## 📦 Struttura del Progetto

- AWS (Provider primario):
  - networking_primary: VPC, subnet pubbliche, internet gateway, route table
  - compute_primary: EC2 con IP pubblico e security group
  - database_primary: RDS MySQL con security group dedicato
- Google Cloud (Provider secondario):
  - networking_secondary: VPC, subnet, firewall rules
  - compute_secondary: VM Compute Engine con IP pubblico e dischi personalizzati
  - database_secondary: Cloud SQL con MySQL, accesso da IP statico + VM
- Failover DNS:
  - route53_failover: gestione del failover tra AWS e GCP tramite record A con routing policy "failover" e health check attivo su AWS
- Analisi dei costi:
  - Integrazione completa con Infracost per il calcolo delle stime di spesa

---

## 📎 File Principali

- `main.tf` Orchestratore principale che richiama tutti i moduli
- `providers.tf` Configurazione dei provider AWS e GCP con alias
- `terraform.tfvars` Valori di input delle variabili legati al costo (usato da Infracost)
- `variables.tf` Variabili condivise tra i moduli
- `infracost.yml` File di configurazione per l'analisi economica
- `outputs.tf` Output chiave come IP pubblici, nome del dominio, DNS configurati
- `modules/` Contiene i moduli riutilizzabili per AWS, GCP e Route 53

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

## 💰 Analisi dei Costi con Infracost

Il file terraform.tfvars contiene solo variabili che impattano economicamente sul piano (es. tipo istanza, dimensione dischi, classe database). Il file infracost.yml specifica i percorsi dei moduli da analizzare.

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

## ⚙️ Funzionamento del Failover DNS

- **Route 53 è configurato con:**
  - Record A primario: punta all'IP pubblico di AWS
  - Record A secondario: punta all'IP pubblico GCP

- **Health Check AWS:**
  - Tipo: HTTPS
  - Path: `/`
  - Porta: `443`
  - Trigger: ogni 30s, failover dopo 3 tentativi falliti

- **Se il controllo fallisce, il traffico viene reindirizzato al secondario (GCP) automaticamente**