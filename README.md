# desafio_eng_devops

Imagem base do Docker: **Ubuntu:14.04**

##Como executar a aplicação:

1 - [Instale o Docker](https://docs.docker.com/engine/installation/)

2 - Faça o Build dos Dockerfiles da aplicação e da base de dados

2.1 - `sudo docker build -f ./Dockerfile.db -t db .`
      `sudo docker build -f ./Dockerfile.app -t web .`

3 - Rode o container da base de dados

3.1 - `sudo docker run -d --name pgsql db`

4 - Rode o container da aplicação

4.1 - Crie a base de dados: `sudo docker run -d --link pgsql:db web /bin/bash -l -c "source /home/rails/.rvm/scripts/rvm && rake db:create"``
                            `sudo docker run -d --link pgsql:db web /bin/bash -l -c "source /home/rails/.rvm/scripts/rvm && rake db:setup"`

4.2 - Inicialize a aplicação: `sudo docker run -d --link pgsql:db web /bin/bash -l -c "source /home/rails/.rvm/scripts/rvm && rails s -b 0.0.0.0"`

5 - Descubra o id do container da sua aplicação com o comando: `sudo docker ps`

5.1 - Descubra o endereço IP da sua aplicação com o comando: `sudo docker inspect <ID DA APLICAÇÃO> | grep IPAddress | cut -d '"' -f 4`

6 - Acesse a aplicação no browser em: http://HOSTNAME:3000
