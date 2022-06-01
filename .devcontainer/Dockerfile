FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-ubuntu-22.04

ARG ARCHITECTURE="amd64"
ARG UBUNTU_CODENAME="jammy"

RUN apt-get update && apt-get install -y --no-install-recommends \
		gcc-11 \
		g++-11 \
		curl \
		build-essential \
		wget \
		python3 \
		pip \
		lsb-release \
		htop \
		git \
		gnupg \
		software-properties-common \
		bash-completion \
		zsh \
	&& rm -rf /var/lib/apt/lists/* \
	&& update-alternatives --remove-all cpp \
	&& update-alternatives \
		--install /usr/bin/gcc gcc /usr/bin/gcc-11 110 \
		--slave /usr/bin/g++ g++ /usr/bin/g++-11 \
		--slave /usr/bin/gcov gcov /usr/bin/gcov-11 \
		--slave /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-11 \
		--slave /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-11 \
		--slave /usr/bin/cpp cpp /usr/bin/cpp-11

RUN add-apt-repository universe

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
	&& echo "deb [arch=$ARCHITECTURE signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get -qq update \
	&& apt-get -qq upgrade

RUN apt-get -qq install -y ros-humble-desktop-full 
RUN apt-get -qq install -y python3-colcon-common-extensions

# Install CMake
ARG CMAKE_VERSION="3.21.1"
RUN curl -L -o /tmp/cmake.tar.gz https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz \
	&& mkdir -p /tmp/cmake \
	&& tar -xzf /tmp/cmake.tar.gz \
		-C /tmp/cmake \
		--strip-components 1 \
		--exclude bin/cmake-gui        \
		--exclude doc/cmake            \
		--exclude "share/cmake-*/Help" \
	&& cp -rf /tmp/cmake/* /usr \
	&& rm -rf /tmp/cmake \
	&& rm /tmp/cmake.tar.gz

RUN usermod -l ros2 -d /home/ros2 -m "vscode" \
	&& groupmod -n ros2 vscode \
	&& rm /etc/sudoers.d/vscode \
	&& echo "ros2 ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ros2

USER ros2

# Comment below lines if you don't want to use Zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
	&& git clone https://github.com/zsh-users/zsh-autosuggestions         ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions     \
	&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
	&& git clone https://github.com/zsh-users/zsh-completions             ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions         \
	&& git clone https://github.com/supercrabtree/k                       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
ADD .zshrc /home/ros2
ENV SHELL /bin/zsh
