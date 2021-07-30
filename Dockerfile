FROM ubuntu:hirsute-20210422

## Install pandoc and texlive, using noninteractive mode to get around tzdata
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y texlive pandoc
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget

## Install extras to run Eisvogel
## SEE: https://github.com/Wandmalfarbe/pandoc-latex-template/issues/141#issuecomment-576005221 for details
RUN DEBIAN_FRONTEND=noninteractive apt install -y texlive-latex-extra xzdec
#RUN tlmgr init-usertree && tlmgr install adjustbox babel-german background bidi collectbox csquotes everypage filehook footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor  titling ucharcat ulem unicode-math upquote xecjk xurl zref
RUN apt-get install -y texlive-fonts-recommended texlive-fonts-extra
RUN apt-get install -y texlive-xetex
RUN apt-get install -y lmodern
## RUN tlmgr install sourcecodepro sourcesanspro

#RUN mkdir -p /wdir
#RUN wget -O /wdir/xeboiboites.sty https://raw.githubusercontent.com/alexisflesch/xeboiboites/master/xeboiboites.sty

## Install Eisvogel template
WORKDIR /tmp
RUN mkdir -p /root/.pandoc/templates
#RUN wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v2.0.0/Eisvogel-2.0.0.tar.gz
RUN wget https://github.com/stephenVertex/pandoc-latex-template/archive/refs/tags/sjb-custom-2.0.2.tar.gz
RUN mkdir -p eisvogel && tar -xvzf sjb-custom-2.0.2.tar.gz -C eisvogel && cp eisvogel/pandoc-latex-template-sjb-custom-2.0.2/eisvogel.tex /root/.pandoc/templates/eisvogel.latex
#ADD eisvogel.tex /root/.pandoc/templates/eisvogel.latex

RUN apt-get update && apt-get install -y python3-pip
RUN pip install --user pandoc-include

