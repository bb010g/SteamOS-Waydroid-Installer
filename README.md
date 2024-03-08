# SteamOS Waydroid Installer

## Container-based build steps

```sh
podman image build -t holo-oci-sysext -f holo-oci-sysext/Containerfile --ignorefile holo-oci-sysext/.containerignore "https://github.com/89luca89/oci-sysext.git"
podman container run --rm holo-oci-sysext pull docker.io/alpine:latest

podman image build -t holo-waydroid--bundle--repo --target holo-waydroid--bundle--repo .
# If you'd like a full container (e.g. for interactive use):
podman image build -t holo-waydroid--bundle --target holo-waydroid--bundle .
# To explore full container:
podman container run --rm --tty -i holo-waydroid--bundle bash
```
