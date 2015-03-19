FROM centos
# cd to that directory
WORKDIR /tmp
# we need to get pip, so the "easiest" way to do that is the download the file to a temp directory
RUN curl -O https://bootstrap.pypa.io/ez_setup.py
# run it
RUN python ez_setup.py
# and install pip
RUN easy_install pip
# copy over the pip requirements file
ADD requirements.txt /tmp/
# now that we have pip, we can install all the modules we want
RUN pip install -r requirements.txt
