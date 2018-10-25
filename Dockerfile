FROM centos:latest
LABEL description="ESMF development environment"

RUN yum install -y curl
RUN yum upgrade -y
RUN yum update -y
RUN yum clean all
RUN yum -y install gcc gcc-c++ gcc-gfortran mpich-devel make git
ENV PATH="/usr/lib64/mpich/bin:${PATH}"

WORKDIR /usr/src/

RUN git clone --depth 1 https://git.code.sf.net/p/esmf/esmf

# Install ESMF
ENV ESMF_DIR=/usr/src/esmf
ENV ESMF_COMM="mpich3"
ENV ESMF_COMPILER="gfortran"
ENV ESMF_INSTALL_PREFIX="/usr/local"
ENV ESMF_INSTALL_LIBDIR="/usr/local/lib"
ENV ESMF_INSTALL_MODDIR="/usr/local/mod"
ENV ESMF_INSTALL_BINDIR="/usr/local/bin"
ENV ESMF_INSTALL_DOCDIR="/usr/local/doc"
ENV ESMFMKFILE="/usr/local/lib/esmf.mk"

RUN cd esmf && make -j4 lib
RUN cd esmf && make install
