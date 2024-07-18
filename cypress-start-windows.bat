@echo off
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set date=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set time=%%a%%b)
set CYPRESS_API_URL=https://ata-e2e.est.k8s.dev.desk.spctrm.net/
cy2 run --record --key XXX --parallel --ci-build-id %date%_%time%
