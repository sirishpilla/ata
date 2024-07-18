# Agent Training Academy Front-End

## [API Documentation](https://ata-docs.est.k8s.dev.desk.spctrm.net/)

## Setup

### Open a new command prompt & Run:

1. `mkdir C:\Users\{yourPID}\projects`
1. `cd C:\Users\{yourPID}\projects`
1. `git clone git@gitlab.ccit.ops.charter.com:agent-training-academy/agent-training-academy-ui.git`
1. `cd agent-training-academy-ui`
1. `npm install` (if you receive an error here, follow [these instructions](#if-cypress-fails-to-install))
1. `npm start`

### If cypress fails to install

1. Download https://artifacts.bss.corp.chartercom.com/repository/bss-raw-hosted/cypress/8.3.0/cypress.zip
1. Unzip cypress.zip to: `C:\Users\{yourPID}\AppData\Local\Cypress\Cache\8.3.0\`
1. Verify directory structure is correct: `C:\Users\{yourPID}\AppData\Local\Cypress\Cache\8.3.0\Cypress\Cypress.exe`
1. Run `npm install` again in `C:\Users\{yourPID}\projects\agent-training-academy-ui\`

#### Quick Links

- [Technical Documentation](DOCUMENTATION.md)
- [API Documentation](https://ata-docs.est.k8s.dev.desk.spctrm.net/)
- [E2E Testing Dashboard](https://ata-e2e-dashboard.est.k8s.dev.desk.spctrm.net/)

#### Table of Content

1. [Commands](#commands)
    1. [Dev commands](#dev-commands)
    1. [Build commands](#build-commands)
    1. [Test commands](#test-commands)
1. [Coding Standards](#standards)
1. [General Concerns](#general-concerns)
1. [General feedback and discussions](#general-feedback-and-discussions)
1. [Submitting a pull request](#submitting-a-pull-request)
1. [Tests](#tests)
1. [Updating SAML Certs](#saml-updates-(api))

## Commands

### Dev commands

- **npm start** - starts dev environment
- **npm run format** - runs prettier on entire project, writing format changes to the files
- **npm run format:check** - runs prettier on entire project without writing any changes
- **npm run lint** - runs eslint on the `src` directory
- **npm run lint:setup** - runs initial eslint setup
- **npm run lint:fix** - runs eslint on the `src` directory, automatically fixing problems
- **npm run tsc** - runs typescript tsc command (https://www.typescriptlang.org/docs/handbook/compiler-options.html)

### Build commands
- **npm run build:dev** - build app for the dev environments
- **npm run build:staging** - build app for qa & prod (uat) environments
- **npm run build:production** - build app for qa & prod (uat) environments (currently a duplicate as build:staging)

### Test commands
- **npm run test** - runs jest unit tests
- **npm run test:watch** - runs jest unit tests with --watch
- **npm run test:update** - runs jest --updateSnapshot to update snapshot artifacts (used in snapshot testing)
- **npm run test:coverage** - runs jest --coverage for outputing coverage information
- **npm run test:sonar** - runs jest --coverage --testResultsProcessor jest-sonar-reporter
- **npm run sonar** - runs sonarqubeScanner (`node sonar-project.js`)
- **npx cypress open** - opens cypress gui to run the tests

### Deployments

- **Dev Deployment** - build and deploy jobs automatically run when we merge feature branch into dev
- **QA Deployment** -
  - First update the version numbers and the branch name in https://gitlab.spectrumflow.net/cot/desktop-tools/development/ata/agent-training-academy-ui/-/blob/dev/version.yml
  - Then Create a release branch in local with name matching the Branch Name in versions file.
  - Update the tag with the version number in argo repo to create right image in QA
    - https://gitlab.spectrumflow.net/cot/desktop-tools/development/ata/argo-deployments/-/blob/main/workload-ata-ui/overridden-values/qa-east-desk-ata-values.yaml
    - https://gitlab.spectrumflow.net/cot/desktop-tools/development/ata/argo-deployments/-/blob/main/workload-ata-ui/overridden-values/qa-west-desk-ata-values.yaml
  - Push the release branch to remote and you can find the QA Pipeline which shows up when branch name mathces with the branchName variable in versions file
  - Now simply run the deploy job to deploy through rancher and Sync in ArgoCD to redoploy it using the image from nexus repo.



## Coding Standards

- A good reference for standards & best practices (written with .NET in mind) can be found here: [NICE Project Readme](https://bitbucket.corp.chartercom.com/projects/TMS/repos/nice/browse/readme.md)
- Use `styled-components` for future styling. Don't use viewport height (`vh`) to size components. Avoid using `!important`.
- Prevent creating large files (e.g. files larger than 500 lines is large)
- Abstract out smaller components into a "components" directory, and functions into a "utils" directory.
- Build larger components and pages through the use of smaller components.  (Think "components" like "legos").

## General Concerns:

- not enough generic, reusable, functions in the `./utils` directory.
- not enough generic, reusable, components in the `./component` directory. (determine reusable components by abstracting out duplicate code)
- large files in the `./navs` directory should be broken down into reusable components
- styling should stay consistent.  The general consensus is that we may want to move to `styled-components` after finishing the re-skinning.
- We will be moving away from using data in `./constants` and into a relational database.

## General feedback and discussions?
The number one place to be for discussion is
our ATA Dev Team channel.

### Submitting a pull request

We loosely follow the [GitHub Flow](https://guides.github.com/introduction/flow/) process with our pull requests
with a few minor additions

1. Open a PR after your first commit - This ensures discussion can start early
and any concerns can be discussed early
2. Create a descriptive title and a detailed description. If possible reference
the issue that the PR resolves.
3. Commit often
4. When you feel you're complete, request a review
5. Work through any of the review comments
6. Merge once approved
7. Celebrate!

#### Tests

-  Tests need to be provided for every bug/feature that is completed.
-  100% test coverage is desired, but not plausible.

#### Misc. tips (front-end)

### Writing Troubleshooting flows

- First, create objects for the layout of the flow  
  - see: https://gitlab.spectrumflow.net/cot/desktop-tools/development/ata/agent-training-academy-ui/-/merge_requests/700/diffs
- Second, write the contents for each step for the flow
- If needed, write new components that match the steps for the flow  

#### SAML Updates (api)

Updating SAML Cert should be easy:

1. You should be given a certificate file that starts with `-----BEGIN CERTIFICATE-----` 
    - If not, go to https://login.esso-uat.charter.com:8443/nidp/saml2/metadata & copy the value inside the `<ds:X509Certificate>` tags (there will be multiple, but they should all be the same)
e.g. the new cert from 2022 was:

```
MIIG0zCCBbugAwIBAgIQAx++SfHbIqzR8bcOgwzRDzANBgkqhkiG9w0BAQsFADBNMQswCQYDVQQG EwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMScwJQYDVQQDEx5EaWdpQ2VydCBTSEEyIFNlY3Vy ZSBTZXJ2ZXIgQ0EwHhcNMjIwMzIzMDAwMDAwWhcNMjMwNDEzMjM1OTU5WjCBhTELMAkGA1UEBhMC VVMxETAPBgNVBAgTCE1pc3NvdXJpMRIwEAYDVQQHEwlTdC4gTG91aXMxLjAsBgNVBAoTJUNoYXJ0 ZXIgQ29tbXVuaWNhdGlvbnMgT3BlcmF0aW5nLCBMTEMxHzAdBgNVBAMMFiouZXNzby11YXQuY2hh cnRlci5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCdC29A18IJpPV+b5T2yUPc uKWyIZ61Vz4QzeWlLvCr6BMQziAq2vozbFnjXz6/X+PW0LHB5+tMhrUJhHs3ASHFYQ3mHFVotQVa ICfVkYmL8D0JirBYf7RbPo12+JOn7yREbOOG3oK/tUPG22KWrFwV21DR6/xmKH6G93d1G3VhBQmn 1tQ5ZSmW8XKMcRwBWQIqBaFugzMcSD18Pg24P1erp5K3L6FQC4R7XZx0WdYyM+zonvLDL2tvoVm8 qFAbbxTvXBhjuTq1QCQuP7G7Pvxg8EvOIaLxwoN2fooT7Gc36tXgmmX976i2CMFq8KuYfDwT0prz ByfJ7Y1n0aCAzCrRAgMBAAGjggN0MIIDcDAfBgNVHSMEGDAWgBQPgGEcgjFh1S8o541GOLQs4cbZ 4jAdBgNVHQ4EFgQUe4i1IW9kECtLWFC0U2GwWgyXuiYwIQYDVR0RBBowGIIWKi5lc3NvLXVhdC5j aGFydGVyLmNvbTAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMC MIGNBgNVHR8EgYUwgYIwP6A9oDuGOWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpY2VydFNI QTJTZWN1cmVTZXJ2ZXJDQS0xLmNybDA/oD2gO4Y5aHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0Rp Z2ljZXJ0U0hBMlNlY3VyZVNlcnZlckNBLTEuY3JsMD4GA1UdIAQ3MDUwMwYGZ4EMAQICMCkwJwYI KwYBBQUHAgEWG2h0dHA6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzB+BggrBgEFBQcBAQRyMHAwJAYI KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBIBggrBgEFBQcwAoY8aHR0cDovL2Nh Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0U0hBMlNlY3VyZVNlcnZlckNBLTIuY3J0MAkGA1Ud EwQCMAAwggF/BgorBgEEAdZ5AgQCBIIBbwSCAWsBaQB3AK33vvp8/xDIi509nB4+GGq0Zyldz7EM JMqFhjTr3IKKAAABf7a28JIAAAQDAEgwRgIhAIIUfv2QRGFmJwC44+aeU/IHNYYYi6bh0QvSlMKk 1MB1AiEArwT9H9ogBS1Azl34voUEHFuDbEpH53gcEXdwS/PjIUgAdgA1zxkbv7FsV78PrUxtQsu7 ticgJlHqP+Eq76gDwzvWTAAAAX+2tvBqAAAEAwBHMEUCIQCMZ+fXzzilLlQpehydVZJAxXB6lXuS 6istD7iVC7jNvAIgYGJOopNx4dPR8ZPGySVYW6qnS6r9a8QyeyjfSq58TUsAdgCzc3cH4YRQ+GOG 1gWp3BEJSnktsWcMC4fc8AMOeTalmgAAAX+2tvCMAAAEAwBHMEUCICg+IW2/J0eiA6FWLTx/HhHO 8CZe1r09zVmCnzQDl0SsAiEA3GCR9ioBNl4Sa/YU/vk/PRzEpO1CVor8m1tMPF4ro3owDQYJKoZI hvcNAQELBQADggEBAFoTu5gZm21sTMMgkGDT5Lb9LcpVesuyKDqt9z3+vMdiF5uQao0uUxDsFst3 VKKgEacgM1n3JzsZWkJJ2NhvQ51+hwLE4t1CG59NJ1yfclJtb3AcP3R/IK/uKFQWhb6iBnQLq//+ wjxn/Ng/Qoz+zrEYOpT1JomnLzMQNIzjdcPpTAIy3d+ShONaZ91M9WgTgEXVO2Qugmv5Q5JDe8NT 6BB1zRLKCrLAzFVUhQ6F7KzJi93uhNX+G5u0BNFUjYVUcQJO+sICeXGQA+qjigsOrCDm4TJSlkwZ N2FG60PbMeges2h1SRs1v1HvizTlTaorph4Qt3VgMIuxRm3ibqbkFHg=
```

2. next, remove the spaces, so it fits on one line:

```
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
```

3. then, all you need to do is update the idp_cert variable in the server.js to this new value

```js
var idp_cert = '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'
```

4. save the file, and restart the server. your cert should be updated.