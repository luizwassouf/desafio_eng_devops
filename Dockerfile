FROM lwassouf/desafio_eng_devops:0.1
# Install vim.
RUN apt-get update && apt-get install -y vim

# Expose ports.
EXPOSE 80
