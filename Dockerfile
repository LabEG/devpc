
FROM labeg/centos-lxqt-vnc:41

LABEL maintainer="labeg@mail.ru" \
      io.k8s.description="Container with tools for development C# and Typescript applications" \
      io.k8s.display-name="Container with C# ant Typescript" \
      io.openshift.expose-services="5901:xvnc" \
      io.openshift.tags="c#, typescript, vnc, centos, lxqt" \
      io.openshift.non-scalable=true

USER root

# dotnet vscode nodejs
RUN sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

RUN dnf install -y geany git code falkon dotnet-sdk-8.0 nodejs gnome-system-monitor \
      && \
      npm install -g typescript npm-check-updates \
      && \
      dotnet --version && node -v && tsc -v \
      && \
      chown headless:headless -R ${HOME} \
      && \
      dnf clean all \
      && \
      rm -rf /var/cache/dnf/*

# add vscode icon to quicklaunch
RUN echo 'apps\3\desktop=/usr/share/applications/code.desktop' >> ${HOME}/.config/lxqt/panel.conf
RUN sed -i 's/code --unity/code --no-sandbox --unity/' /usr/share/applications/code.desktop

USER headless

# RUN code --install-extension dbaeumer.vscode-eslint && \
#     code --install-extension visualstudioexptteam.vscodeintellicode && \
#     code --install-extension ms-dotnettools.csdevkit
