FROM nnurphy/conda:latest

RUN set -ex \
  ; apt-get update \
  ; apt-get install -y --no-install-recommends \
      cmake build-essential \
      # rust
      libzmq3-dev pkg-config libssl-dev \
      # debug
      lldb libxml2 \
      # haskell
      python3-dev python3-wheel \
      libncurses-dev libtinfo-dev libblas-dev liblapack-dev \
      libcairo2-dev libpango1.0-dev libmagic-dev \
      # stack
      libicu-dev libffi-dev libgmp-dev zlib1g-dev \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# ### GO
# ENV GOROOT=/opt/go GOPATH=${HOME}/go
# ENV PATH=${GOPATH}/bin:${GOROOT}/bin:$PATH
# ENV GO111MODULE=on
# RUN set -ex \
#   ; cd /opt \
#   ; GO_VERSION=$(curl https://golang.org/VERSION?m=text) \
#   ; curl -sSL https://dl.google.com/go/${GO_VERSION}.linux-amd64.tar.gz \
#       | tar xzf - \
#   ; go get -u github.com/gopherdata/gophernotes \
#   ; gophernotes_dir=${HOME}/.local/share/jupyter/kernels/gophernotes \
#   ; mkdir -p $gophernotes_dir \
#   ; cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes*/kernel/* $gophernotes_dir \
#   ; chmod +w $gophernotes_dir/kernel.json \
#   ; sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < $gophernotes_dir/kernel.json.in > $gophernotes_dir/kernel.json \
#   ; go get golang.org/x/tools/gopls@latest \
#   ; rm -rf $(go env GOCACHE)/*
#
# RUN set -eux \
#   ; nvim_home=/etc/skel/.config/nvim \
#   ; $nvim_home/plugged/vimspector/install_gadget.py --enable-go \
#   ; rm -f $nvim_home/plugged/vimspector/gadgets/linux/download/*/*/*.vsix

### Racket
#ENV RACKET_HOME=/opt/racket RACKET_VERSION=7.3
#ENV PATH=${RACKET_HOME}/bin:$PATH
#
#RUN set -ex \
#  ; apt-get install -y --no-install-recommends \
#      libcairo2 libpango-1.0-0 libpangocairo-1.0 \
#  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
#  ; url=https://mirror.racket-lang.org/installers/${RACKET_VERSION}/racket-minimal-${RACKET_VERSION}-x86_64-linux.sh \
#  #; curl -sSL $url | sh -s -- --in-place --dest ${RACKET_HOME} \
#  ; curl -sSLo racket.sh $url \
#  ; sh ./racket.sh --in-place --dest ${RACKET_HOME} \
#  ; rm ./racket.sh \
#  ; raco pkg install --auto iracket \
#  ; racket -l iracket/install \
#  ; rm -rf ${HOME}/.racket/download-cache




### idris
#ENV IDRIS_ROOT=${HOME}/idris
#RUN set -ex \
#  ; mkdir -p ${IDRIS_ROOT} \
#  ; printf "\
#flags: {}\n\
#extra-package-dbs: []\n\
#packages: []\n\
#resolver: ${STACKAGE_VERSION}\n\
#extra-deps:\n\
#  - binary-0.8.7.0\n\
#  - Cabal-2.2.0.1\n\
#  - aeson-1.3.1.1\n\
#  - code-page-0.1.3\n\
#  - containers-0.5.11.0\n\
#  - megaparsec-6.5.0\n\
#  - network-2.7.0.2\n\
#  - zip-archive-0.3.3\n\
#" > ${IDRIS_ROOT}/stack.yaml \
#  ; cd ${IDRIS_ROOT} \
#  ; stack install idris \
#  #; rm -rf ${STACK_ROOT}/global-project/.stack-work/install/x86_64-linux/${STACKAGE_VERSION}/8.6.5/lib/* \
#  ; rm -rf ${STACK_ROOT}/indices/*


### Julia
# ENV JULIA_HOME=/opt/julia
# ENV PATH=${JULIA_HOME}/bin:$PATH
# RUN set -eux \
#   ; julia_version=$(curl -sSL https://julialang.org/downloads/ | pup '#current_stable_release > a text{}' | awk '{print $4}') \
#     | tar xz -C ${JULIA_HOME} --strip-components 1 \
#   ; julia -e 'using Pkg; Pkg.add("IJulia"); using IJulia'


### iTorch
# RUN set -ex \
#   ; apt-get install lua5.3 luarocks software-properties-common \
#   ; git clone https://github.com/torch/distro.git ~/torch --recursive \
#   ; sed -i 's/python-software-properties/software-properties-common/g' ~/torch/install-deps \
#   ; cd ~/torch; bash install-deps \
#   ; ./install.sh \
#   ; apt-get install libzmq3-dev libssl-dev python-zmq luarocks \
#   ; git clone https://github.com/facebook/iTorch.git \
#   ; cd iTorch \
#   ; luarocks make


### ocaml
#ENV OPAMROOT=/opt/opam OPAMROOTISOK=1 OPAMVERSION=2.0.4
#ENV PATH=${OPAMROOT}/default/bin:$PATH
#RUN set -ex \
#  ; apt-get install -y --no-install-recommends m4 bubblewrap libcairo2-dev && apt-get clean \
#  ; curl -sSLo /usr/local/bin/opam https://github.com/ocaml/opam/releases/download/${OPAMVERSION}/opam-${OPAMVERSION}-x86_64-linux \
#  ; chmod +x /usr/local/bin/opam \
#  #; sudo sysctl kernel.unprivileged_userns_clone=1 \
#  ; opam init -a --disable-sandboxing \
#  ; opam install -y "cairo2<0.6" \
#  ; opam install -y jupyter \
#  ; opam install -y jupyter-archimedes \
#  ; opam install -y higher \
#  ; jupyter kernelspec install --name ocaml-jupyter "$(opam config var share)/jupyter" \
#  ; rm -rf ${OPAMROOT}/download-cache/*




### its
#RUN set -ex \
#  ; npm install -g typescript itypescript --unsafe-perm=true --allow-root \
#  ; its --ts-install=global \
#  ; npm cache clean -f

### cling
# RUN conda install xeus-cling notebook -c QuantStack -c conda-forge


# USER ${NB_USER}





### scala
#ENV JAVA_VERSION=11 JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 \
#    SCALA_HOME=/opt/scala SCALA_VERSION=2.12.8 ALMOND_VERSION=0.5.0
#ENV PATH=${SCALA_HOME}/bin:$PATH
#RUN set -ex \
#  ; mkdir -p /usr/share/man/man1 \
#  ; mkdir -p ${SCALA_HOME} \
#  ; apt-get -y --no-install-recommends install openjdk-${JAVA_VERSION}-jdk-headless \
#  ; apt-get clean \
#  ; curl -sSL https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz \
#      | tar xzf - -C ${SCALA_HOME} --strip-components=1  \
#  ; curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier \
#  ; ./coursier bootstrap \
#      -r jitpack \
#      -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
#      sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
#      -o almond \
#  ; ./almond --install
#  #; rm -rf ${HOME}/.cache/coursier/*

### clojure
#RUN set -ex \
#  ; apt-get -y --no-install-recommends install leiningen \
#  ; apt-get clean \
#  ; git clone https://github.com/clojupyter/clojupyter \
#  ; cd clojupyter \
#  ; make \
#  ; make install \
#  ; rm -rf ${HOME}/.m2/repository/*


