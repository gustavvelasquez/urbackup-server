# TECHGV UrBackup Server image

Custom container image for TECHGV, adapted from the Dockerfile and entrypoint maintained by [uroni/urbackup-server-docker](https://github.com/uroni/urbackup-server-docker).

## Version policy

The UrBackup Server package version is pinned in `.github/workflows/build-image.yml` as `2.5.38`.

Published image:
`ghcr.io/gustavvelasquez/urbackup-server:2.5.38`

No `:latest` tag is published. A new UrBackup version is built only after deliberately changing `URBACKUP_VERSION` and running the workflow.

## Persistent paths

- `/var/urbackup`: server database and configuration
- `/backups`: client backup data
- `/var/log`: logs

Keep these paths on persistent Docker volumes or host datasets. Replacing the container image does not require deleting them.

## Build

GitHub Actions builds for `linux/amd64` on pushes to `main`, and can also be started manually from the Actions tab.

The Dockerfile and entrypoint are adapted from the Apache-2.0-licensed project [uroni/urbackup-server-docker](https://github.com/uroni/urbackup-server-docker). See [LICENSE](LICENSE).
