FROM python:3.8

# Dependencies Intall and Update
RUN apt-get update && apt-get install -y \
    build-essential \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

# Python Dependencies
RUN pip install notebook
RUN pip install -U --force-reinstall --no-cache https://github.com/johnhw/jhwutils/zipball/master
RUN pip install -U --force-reinstall --no-cache https://github.com/AlbertS789/lautils/zipball/master

RUN pip install scikit-image numpy matplotlib scipy

RUN pip install spacy
RUN python -m spacy download de_core_news_sm
RUN python -m spacy download en_core_web_sm


RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
RUN pip install -U torchtext==0.10.0

# Workdir
WORKDIR /lab

# Copiar el notebook al contenedor
COPY ./src .

# Exponer el puerto para Jupyter Notebook
EXPOSE 8888

# Comando para ejecutar Jupyter Notebook y mantener el contenedor corriendo
CMD ["sh", "-c", "jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root && tail -f /dev/null"]
