# CLI commands to run independent test feature
mvn test -Dtest=ConvergeBaseRunner -Dkarate.options="--tags @login" -Dkarate.env=dev