FROM alpine
RUN apk --update-cache --no-cache add coreutils git rsync bash openssh

ENV GIT_SSH ssh-url-with-ssh-key
ENV RSYNC_RSH ssh-url-with-ssh-key

COPY ssh-url-with-ssh-key /bin
CMD [ "/bin/bash", "-i" ]
