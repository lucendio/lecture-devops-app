const sonarqubeScanner = require('sonarqube-scanner');

sonarqubeScanner({
  serverUrl: 'http:/http://3.65.199.82:9000/',
       options : {
	    'sonar.projectDescription': 'devops node js',
	    'sonar.projectName': 'nodejs',
	    'sonar.projectKey':'nodejs',
	    'sonar.login': 'sonar',
	    'sonar.password': 'sonar',
            'sonar.projectVersion':'1.0',
	    'sonar.language':'js',
            'sonar.sourceEncoding':'UTF-8',
            'sonar.sources': '.',
	  //'sonar.tests': 'specs',
          //'sonar.inclusions' : 'src/**'
       },
}, () => {});