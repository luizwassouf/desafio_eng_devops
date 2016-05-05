  FROM ubuntu:14.04

  # Initial configuration
  RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    build-essential \
    openssl \
    libreadline6 \
    libreadline6-dev \
    git-core \
    zlib1g \
    zlib1g-dev \
    libssl-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt-dev \
    libgmp-dev \
    autoconf \
    libc6-dev \
    ncurses-dev \
    automake \
    libtool \
    bison \
    nodejs \
    git \
    git-svn \
    gitk \
    ssh \
    postgresql \
    postgresql-contrib \
    postgresql-server-dev-* \
    libssh-dev


  # Add user `rails`
  USER root
  RUN \
    adduser --gecos 'Rails app user' --disabled-password rails && \
    echo "rails ALL = NOPASSWD: /usr/bin/apt-get" >> /etc/sudoers

  USER rails
  WORKDIR /home/rails


  # Install RVM
  RUN /bin/bash -l -c "\
    gpg --homedir /home/rails/.gnupg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    source /home/rails/.rvm/scripts/rvm && \
    rvm requirements "

  # Install ruby and rails
  RUN /bin/bash -l -c "\
    source /etc/profile && \
    echo 'gem: --no-ri --no-rdoc' >> /home/rails/.gemrc && \
    rvm install 2.2.0 && \
    gem install rails:4.2.0 "

  # Clone our private GitHub Repository
  RUN git clone https://github.com/luizwassouf/desafio_eng_devops.git ~/desafio_eng_devops/

  # Changing WORKDIR to /home/rails/desafio_eng_devops
  WORKDIR /home/rails/desafio_eng_devops/desafio

  RUN /bin/bash -l -c "\
    source /home/rails/.rvm/scripts/rvm && \
    bundle install "


  # Expose ports.
  EXPOSE 80
  EXPOSE 3000
  EXPOSE 5432
