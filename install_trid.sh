#!/bin/bash

start_path=$( pwd )
lib_path="${start_path}/scalar"
adi_path="${start_path}/apps/adi"

function build_lib() {
  cd $lib_path
  mkdir build
  cd build
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_FOR_CPU=ON -DBUILD_FOR_GPU=OFF
  make install
  export TRIDSOLVER_INSTALL_PATH=$( pwd )
  export LD_LIBRARY_PATH="${TRIDSOLVER_INSTALL_PATH}/lib:${LD_LIBRARY_PATH}"
  echo "Finished building trid lib"
}

function build_adi() {
  cd $adi_path
  mkdir build
  cd build
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_FOR_CPU=ON -DBUILD_FOR_GPU=OFF
  make
  export TRIDSOLVER_ADI_MPI_PATH=$( pwd )/adi_mpi_cpu
  echo "Finished building ADI app"
}

module swap PrgEnv-cray PrgEnv-intel
module load cmake

build_lib
build_adi

echo "LD_LIBRARY_PATH is set to: ${LD_LIBRARY_PATH}"
echo "TRIDSOLVER_INSTALL_PATH is set to: ${TRIDSOLVER_INSTALL_PATH}"
echo "TRIDSOLVER_ADI_MPI_PATH is set to: ${TRIDSOLVER_ADI_MPI_PATH}"
