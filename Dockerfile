
FROM labeg/centos-lxqt-vnc:latest


LABEL maintainer="labeg@mail.ru" \
      io.k8s.description="Container with tools for development C# and Typescript applications" \
      io.k8s.display-name="Container with C# ant Typescript" \
      io.openshift.expose-services="5901:xvnc" \
      io.openshift.tags="c#, typescript, vnc, centos, lxqt" \
      io.openshift.non-scalable=true

USER root

# dotnet vscode monodevelop nodejs git2
RUN rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm \
        && \
        rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
        sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
        && \
        rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
        su -c 'curl https://download.mono-project.com/repo/centos7-vs.repo | tee /etc/yum.repos.d/mono-centos7-vs.repo' \
        && \
        yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
        && \
        curl -sL https://rpm.nodesource.com/setup_11.x | bash - \
        && \
        dnf install -y geany git2u git2u-gui code monodevelop firefox dotnet-sdk-3.1 nodejs gnome-terminal gnome-system-monitor \
        && \
        npm install -g gulp typescript npm-check-updates \
        && \
        chown headless:headless -R ${HOME}

USER headless

RUN code --install-extension ms-vscode.vscode-typescript-tslint-plugin && \
    code --install-extension ms-vscode.csharp && \
    code --install-extension joelday.docthis && \
    code --install-extension mrmlnc.vscode-remark && \
    code --install-extension eamodio.gitlens
