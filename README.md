# ham-suse
These images are not meant to be used as a host operating system. Please see [BlueWhaleOS](https://github.com/EyeCantCU/BlueWhaleOS/) for more information.

## Usage

If you use distrobox:

    distrobox create -i ghcr.io/eyecantcu/ham-suse -n ham-suse
    distrobox enter ham-suse

Append '--nvidia' for Nvidia GPU support

If you use toolbox:

    toolbox create -i ghcr.io/eyecantcu/ham-suse -c ham-suse
    toolbox enter ham-suse

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/eyecantcu/ham-suse
