FROM alpine

RUN apk add --no-cache bash openssh sqlite
COPY load_bash.sh /etc/profile.d/
COPY middle_earth/ /usr/local/bin/middle_earth
COPY gandalf_letter.txt /opt
COPY root_bashrc /root/.bashrc
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
RUN ssh-keygen -A
RUN rm /etc/motd
CMD ["/usr/sbin/sshd", "-D"]

