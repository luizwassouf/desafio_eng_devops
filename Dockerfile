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
    postgresql \
    postgresql-contrib \
    postgresql-server-dev-* \
    git \
    git-svn \
    gitk \
    ssh \
    libssh-dev

  # Add user `rails`
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
  RUN git clone -b master https://github.com/luizwassouf/desafio_eng_devops.git /home/rails/desafio_eng_devops

  # Define default command.
  CMD ["/bin/bash"]

  # Expose ports.
  EXPOSE 80
  EXPOSE 3000
