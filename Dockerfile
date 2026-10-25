# 홈랩 Node 앱의 공용 베이스 이미지. 앱은 버전 태그로 고정해서 쓴다(FROM ghcr.io/cannalee90/node-base:24.22.1).
# 모든 앱에 공통인 것만 둔다. 한 앱만 쓰는 패키지(git, chromium 등)는 그 앱의 Dockerfile에 둔다.
# Node를 올릴 때: NODE_VERSION을 바꿔 main에 push한다. 그다음 앱마다 FROM의 태그를 바꾼다.
ARG NODE_VERSION=24.22.1
FROM node:${NODE_VERSION}-trixie-slim
# 베이스에 있는 Debian 패키지(libc6, zlib1g 등)를 trixie-security 수정판으로 올린다.
# image 워크플로가 매주 다시 빌드하므로 같은 Node 태그에도 새 수정판이 들어간다.
RUN apt-get update \
	&& apt-get upgrade -y \
	&& rm -rf /var/lib/apt/lists/*
# pnpm 버전은 각 앱 package.json의 packageManager가 정한다.
RUN corepack enable
