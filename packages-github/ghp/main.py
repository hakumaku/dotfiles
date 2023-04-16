import json
from pathlib import Path
from typing import TypedDict, cast

from ghp.api.github import GithubPackgeInfo
from ghp.utils import console
from ghp.utils.run_command import get_command_version


class Package(TypedDict):
    bin: str
    repo: str
    package_pattern: str
    version_command: list[str]
    version_pattern: str
    version_strip_pattern: str | None


class GithubPackageData(TypedDict):
    data: list[Package]


def main() -> None:
    cwd = Path(__file__).parent
    with open(cwd / "packages.json", "r") as fp:
        packages = cast(GithubPackageData, json.load(fp))

    github_packges: list[tuple[GithubPackgeInfo, str | None]] = []

    for package in packages["data"]:
        github_package = GithubPackgeInfo(
            bin=package["bin"],
            repo=package["repo"],
            package_pattern=package["package_pattern"],
        )
        local_version = get_command_version(
            tuple(package["version_command"]),
            package["version_pattern"],
            strip_pattern=package["version_strip_pattern"],
        )
        github_packges.append((github_package, local_version))

    for github_package, local_version in github_packges:
        name = console.info(f"{github_package.bin:>10}")
        pretty_remote_version = console.good(github_package.version)
        pretty_local_version = console.good(local_version or "")

        if (
            local_version == github_package.version
            or f"v{local_version}" == github_package.version
        ):
            print(f"[{name}] Already up to date '{pretty_local_version}'")
            continue

        if local_version is None:
            print(f"[{name}] Downloading '{pretty_remote_version}'")
        else:
            print(
                f"[{name}] Upgrading to '{pretty_remote_version}' from '{pretty_local_version}'"
            )

        github_package.download_and_install()


if __name__ == "__main__":
    main()
