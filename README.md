# ham-arch
These images are not meant to be used as a host operating system. Please see [BlueWhaleOS](https://github.com/EyeCantCU/BlueWhaleOS/) for more information.

## Usage

If you use distrobox:

    distrobox create -i ghcr.io/eyecantcu/ham-arch -n ham-arch
    distrobox enter ham-arch

Append '--nvidia' for Nvidia GPU support

If you use toolbox:

    toolbox create -i ghcr.io/eyecantcu/ham-arch -c ham-arch
    toolbox enter ham-arch

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/eyecantcu/ham-arch
