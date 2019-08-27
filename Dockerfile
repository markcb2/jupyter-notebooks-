FROM jupyter/minimal-notebook


MAINTAINER markberman

USER root


# R install
RUN sudo rm -rf /var/cache/apt/archives/
RUN apt update && apt install -y gnupg2
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN sudo apt update && apt install -y software-properties-common
#RUN sudo apt update
RUN sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN sudo apt clean
RUN sudo apt update && apt install -y --no-install-recommends libcurl4-openssl-dev && apt clean
#RUN sudo apt clean
RUN sudo apt update && apt install -y --no-install-recommends libssl-dev && apt clean
#RUN sudo apt clean
#RUN sudo apt update
RUN sudo apt install -y --no-install-recommends libsodium-dev && apt clean
#RUN sudo apt clean
#RUN sudo apt update
RUN sudo apt update && apt install -y --no-install-recommends r-base r-base-dev curl && apt clean
#RUN sudo apt update
#RUN sudo apt clean

# Utilities for R Jupyter Kernel

RUN echo 'install.packages(c("openssl"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN echo 'install.packages(c("curl"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN echo 'install.packages(c("httr"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN echo 'install.packages(c("base64enc"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R


RUN echo 'install.packages(c("evaluate"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN echo 'install.packages(c("jsonlite"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN echo 'install.packages(c("uuid"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN echo 'install.packages(c("digest"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN echo 'install.packages(c("devtools"), \
repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN apt update && apt install -y --no-install-recommends libzmq3-dev && apt-get clean

# Install R Jupyter Kernel
RUN echo 'install.packages(c("repr", "IRdisplay", "crayon", "pbdZMQ"),repos="https://cloud.r-project.org/", dependencies=TRUE)' > /tmp/packages.R && Rscript /tmp/packages.R
RUN echo 'devtools::install_github("IRkernel/IRkernel")' > /tmp/packages.R && Rscript /tmp/packages.R
#RUN conda install -c r r-irkernel

# Install R kernel
RUN echo 'IRkernel::installspec()' > /tmp/temp.R && Rscript /tmp/temp.R

#Run the notebook
CMD jupyter notebook \
    --ip=* \
    --MappingKernelManager.time_to_dead=10 \
    --MappingKernelManager.first_beat=3 \
    --notebook-dir=/notebooks-dir/
