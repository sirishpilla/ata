const sonarqubeScanner = require('sonarqube-scanner');
sonarqubeScanner(
  {
    serverUrl: 'http://artifacts.bss.corp.chartercom.com:9000',
    token: '6087496bbd49f131212249f40e386ca93b79210d',
    options: {
      'sonar.sources': 'src',
      'sonar.projectKey': 'agent-training-academy',
      'sonar.exclusions': '**/__tests__/**,node_modules/**,src/assets/*',
      'sonar.tests': 'src/__tests__',
      'sonar.test.inclusions':
        'src/__tests__/**/*.test.jsx,src/__tests__/**/*.test.js',
      'sonar.typescript.lcov.reportPaths': 'coverage/lcov.info',
      'sonar.testExecutionReportPaths': 'coverage/test-report.xml',
    },
  },
  () => {}
);
