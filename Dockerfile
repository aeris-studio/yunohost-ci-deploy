FROM debian:9.5-slim


# Update
RUN apt-get update


# Install packages
RUN apt-get -yq install rsync openssh-client


# Label
LABEL "com.github.actions.name"="YunoHost CI Deployment"
LABEL "com.github.actions.description"="For deploying to YunoHost CI via rsync over ssh"
LABEL "com.github.actions.icon"="truck"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="http://github.com/aeris-studio/yunohost-ci-deploy"
LABEL "homepage"="https://github.com/aeris-studio/yunohost-ci-deploy"
LABEL "maintainer"="Aeris <aeris@e.email"


# Copy entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

