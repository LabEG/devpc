
FROM labeg/centos-lxqt-vnc:latest


LABEL maintainer="labeg@mail.ru" \
      io.k8s.description="Container with tools for development C# and Typescript applications" \
      io.k8s.display-name="Container with C# ant Typescript" \
      io.openshift.expose-services="5901:xvnc" \
      io.openshift.tags="c#, typescript, vnc, centos, lxqt" \
      io.openshift.non-scalable=true

USER root

# dotnet vscode monodevelop nodejs
RUN rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm \
        && \
        rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
        sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
        && \
        rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
        su -c 'curl https://download.mono-project.com/repo/centos7-vs.repo | tee /etc/yum.repos.d/mono-centos7-vs.repo' \
        && \
        dnf install -y git code monodevelop chromium dotnet-sdk-2.2 nodejs gnome-terminal gnome-system-monitor \
        && \
        curl -sL https://rpm.nodesource.com/setup_11.x | bash - \
        && \
        npm install -g gulp typescript \
        && \
        sudo -H -u headless bash -c 'code --install-extension ms-vscode.vscode-typescript-tslint-plugin; code --install-extension ms-vscode.csharp;'

USER headless