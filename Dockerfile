FROM jupyter/r-notebook
RUN conda install --yes \
    'r-xlsx' \
    'r-data.table' \
    'r-rmysql' \
    'r-rjava' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR
RUN conda install --yes -c bioconda \
    'bioconductor-rhdf5' 
RUN conda install --yes -c r 'r-xml'
RUN conda install --yes -c conda-forge \
    'r-httpuv' \
    'r-sqldf'


