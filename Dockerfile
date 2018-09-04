FROM jupyter/r-notebook:279b14bbdda3
COPY requirements.txt /tmp/
RUN conda install --yes --file /tmp/requirements.txt  && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
