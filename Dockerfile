FROM quay.io/jlopsti/ocp-tomcat:1

COPY . /opt/apache-tomcat-7.0.88/webapps/ROOT/

ENV SSH_PASSWD "root:Docker!"

RUN touch /opt/apache-tomcat-7.0.88/logs/catalina.out && \
    chmod 777 /opt/apache-tomcat-7.0.88/logs /opt/apache-tomcat-7.0.88/work && \
    chmod 666 /opt/apache-tomcat-7.0.88/logs/catalina.out /opt/apache-tomcat-7.0.88/conf/* && \
    chown -R 1001:1001 /opt/apache-tomcat-7.0.88 && \
    echo "$SSH_PASSWD" | chpasswd

COPY sshd_config /etc/ssh

EXPOSE 8080 2222

RUN useradd -u 1001 tomcatuser
USER tomcatuser

CMD /opt/apache-tomcat-7.0.88/bin/startup.sh & tail -F /opt/apache-tomcat-7.0.88/logs/catalina.out
