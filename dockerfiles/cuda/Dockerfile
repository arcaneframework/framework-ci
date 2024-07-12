# Ubuntu 24.04 .
# Version with .

FROM localhost/test:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# RUN apt-get update -y \
#     && apt-get install -y nvidia-cuda-toolkit \
#     && apt-get remove -y nsight-compute nsight-systems nvidia-visual-profiler \
#     && apt-get autoremove -y \
#     && rm -rf /var/lib/apt/lists/*

COPY build_scripts/ /root/build_scripts/
RUN /root/build_scripts/cuda.sh
