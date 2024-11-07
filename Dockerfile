FROM tomcat:8.0.20-jre8

COPY target/my-web-app*.war /usr/local/tomcat/webapps/my-web-app.war
