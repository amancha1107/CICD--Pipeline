#jboss/wildfly
#FROM is base image of dockerhub i.e baseimage:01
FROM vijay2181/baseimage:01
ADD ./samplewar/target/samplewar.war /opt/jboss/wildfly/standalone/deployments/
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
