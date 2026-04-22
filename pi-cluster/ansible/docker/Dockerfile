FROM alpine/ansible:2.14.5

RUN apk add sshpass terraform && \
    ansible-galaxy collection install cloud.terraform community.general

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
