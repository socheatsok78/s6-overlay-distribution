
variable "ALPINE_VERSION" { default = "latest" }
variable "S6_OVERLAY_VERSION" { default = "v3.2.0.0" }

target "docker-metadata-action" {}
target "github-metadata-action" {}

group "default" {
    targets = [
        "s6-overlay",
        "s6-overlay-symlinks",
        "s6-overlay-syslogd",
    ]
}

target "s6-overlay" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    context = "s6-overlay"
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64",
        "linux/riscv64",
        "linux/s390x",
        "linux/386",
        "linux/arm/v7",
        "linux/arm/v6"
    ]
}

target "s6-overlay-symlinks" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
        "s6-overlay"
    ]
    context = "s6-overlay-symlinks"
}

target "s6-overlay-syslogd" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
        "s6-overlay"
    ]
    context = "s6-overlay-syslogd"
}

target "dev" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    context = "s6-overlay"
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
    }
    tags = [
        "socheatsok78/s6-overlay-distribution:dev"
    ]
}
