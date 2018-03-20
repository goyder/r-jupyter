FROM jupyter/r-notebook
RUN conda install --quiet --yes \
    'r-xlsx' \
    'r-data.table' \
    'r-rjava' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

