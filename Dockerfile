FROM ubuntu:18.10

MAINTAINER Denis Shvetsov

RUN apt update && \
    apt -y install \
    git nano vim iperf iperf3 tcpdump netcat sudo tmux wget make

# RUN apt update && apt -y install opam

RUN apt update && \
    apt -y install ocaml

RUN wget https://github.com/ocaml/opam/archive/2.0.3.tar.gz && tar -xvzf 2.0.3.tar.gz && \
    cd opam-2.0.3 && make lib-ext && ./configure && make && make install

RUN apt -y install rsync mercurial darcs
RUN apt -y install packup  mccs
RUN apt -y install unzip m4 bubblewrap

RUN apt update && apt -y install gcc g++

RUN opam init --disable-sandboxing && opam switch create 4.06.0

RUN opam install dune
RUN eval $(opam config env) && opam install --yes async async_extended base base64 cohttp core
RUN eval $(opam config env) && opam install --yes cppo cstruct ipaddr mparser
RUN eval $(opam config env) && opam install --yes ocaml-migrate-parsetree ocamlgraph open ppx_compare
RUN eval $(opam config env) && opam install --yes ppx_cstruct ppx_deriving ppx_enumerate ppx_fields_conv
RUN eval $(opam config env) && opam install --yes ppx_hash ppx_sexp_conv ppxlib sedlex sexplib
RUN eval $(opam config env) && opam install --yes tcpip yojson
RUN eval $(opam config env) && opam install --yes menhir
RUN eval $(opam config env) && opam install --yes cohttp-async cppo cstruct-async menhir

RUN apt update && apt -y install time

WORKDIR /root

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /userdata

COPY bashrc.sh /etc/bashrc.sh
COPY entrypoint.sh /sbin/entrypoint.sh
COPY path.sh /etc/profile.d

ENTRYPOINT ["/sbin/entrypoint.sh"]
