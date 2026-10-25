# node-base

홈랩 Node 앱(code-review, homelab-log-agent, llm-wiki)과 obsidian-sync가 함께 쓰는 베이스 이미지다.

- 이미지: `ghcr.io/cannalee90/node-base:<Node 버전>` (linux/arm64, 공개)
- 내용: `node:<버전>-trixie-slim` + `apt-get upgrade` + `corepack enable`
- 매주 월요일 04:00(KST)에 같은 태그로 다시 빌드한다. 앱은 다음 빌드 때 새 Debian 수정판을 받는다.

## Node 버전 올리기

1. `Dockerfile`의 `ARG NODE_VERSION`을 바꿔 main에 push한다. Actions가 `:<새 버전>` 태그를 올린다.
2. 각 앱 저장소의 Dockerfile `FROM` 태그를 새 버전으로 바꾼다. 앱의 image 워크플로가 다시 빌드한다.
3. kangho-argocd의 `k8s/apps/llm-wiki/obsidian-sync.yaml` 이미지 태그를 바꾼다.
4. ocr-pr-reviewer는 kangho-argocd의 `newTag`를 직접 올린다. 다른 앱은 Image Updater가 올린다.
