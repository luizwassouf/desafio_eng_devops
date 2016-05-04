FROM ubuntu:14.04

# Initial configuration
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install curl -y


# Define default command.
CMD ["ls"]

# Expose ports.
EXPOSE 80
EXPOSE 3000
