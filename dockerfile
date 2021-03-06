FROM ubuntu

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
build-essential \
curl \
git \
&& rm -rf /var/lib/apt/lists/*

RUN curl -qsSLkO \
https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-`uname -p`.sh \
&& bash Miniconda3-latest-Linux-`uname -p`.sh -b \
&& rm Miniconda3-latest-Linux-`uname -p`.sh

ENV PATH=/root/miniconda3/bin:$PATH

RUN conda install -y \
h5py \
pandas \
keras \
tensorflow \
&& conda clean --yes --tarballs --packages --source-cache

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
graphviz \
&& rm -rf /var/lib/apt/lists/* \
&& conda install -y \
pydot \
jupyter \
matplotlib \
seaborn \
&& conda clean --yes --tarballs --packages --source-cache

RUN pip --no-cache-dir install numpy scipy sklearn
VOLUME /notebook
WORKDIR /notebook
EXPOSE 8888
CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --NotebookApp.allow_origin='*'