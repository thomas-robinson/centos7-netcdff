FROM spack/centos7

#RUN yum update -y 
#RUN yum install -y python3
#RUN yum -y install git
#RUN yum -y install which
#RUN yum -y install gcc

#RUN git clone -b releases/v0.15 https://github.com/spack/spack /home/spack
#RUN cd /home/spack
#RUN . /home/spack/share/spack/setup-env.sh

#RUN yum -y install make
#RUN yum -y install patch
#RUN rpm -Uvh epel-release*rpm
#RUN yum -y install lbzip2
#RUN yum -y install bzip2
RUN spack install gcc@10.1.0
RUN spack compiler find `spack location -i gcc@10.1.0`
RUN spack load gcc 
RUN spack install mpich@3.3.2 %gcc@10.1.0
RUN spack load mpich
RUN spack install netcdf-fortran@4.4.4 ^netcdf-c~mpi @4.7.4 ^hdf5~mpi @1.12.0 %gcc@10.1.0
RUN spack load netcdf-fortran
RUN spack load netcdf-c
RUN gcc=`spack location -i gcc`
RUN mpich=`spack location -i mpich`
RUN netcdfc=`spack location -i netcdf-c`
RUN netcdff=`spack location -i netcdf-fortran`

ENV PATH=$netcdfc/bin:$netcdff/bin:$mpich/bin:$gcc/bin:$PATH
ENV LD_LIBRARY_PATH=$netcdfc/lib:$netcdff/lib:$mpich/lib:$gcc/lib:$LD_LIBRARY_PATH
ENV LIBRARY_PATH=$LD_LIBRARY_PATH

#ENV PATH=$(spack location -i mpich)/bin:$(spack location -i gcc)/bin:$(spack location -i netcdf-c)/bin:$(spack location -i netcdf-fortran)/bin:$PATH
