FROM tomcat:8.0.20-jre8
# Dummy text to test sdjsjsalk 
COPY target/*.war /usr/local/tomcat/webapps/vprofile-v1.war
