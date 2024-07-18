@echo off
set CYPRESS_API_URL=https://ata-e2e.est.k8s.dev.desk.spctrm.net/
cy2 open --config-file cypress.dev.json
