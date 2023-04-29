import re
import shutil
import stat
import tempfile
from functools import cached_property, lru_cache
from pathlib import Path
from typing import Any, cast

import requests

from ghp.utils import console
from ghp.utils.parse import parse_version


@lru_cache(maxsize=8)
def _get_github_package_version(matched_url: str) -> str | None:
    return parse_version(matched_url, match_pattern=r".*/(v?[.\d]*)/")


class GithubPackgeInfo:
    def __init__(self, bin: str, repo: str, package_pattern: str):
        self.bin = bin
        self.repo = repo
        self._package_pattern = package_pattern

    def __str__(self) -> str:
        return f"<{self.__class__.__name__} '{self.repo}'>"

    @cached_property
    def info(self) -> dict[str, Any]:
        url = f"https://api.github.com/repos/{self.repo}/releases/latest"
        response = requests.get(url)
        if response.status_code != 200:
            raise AttributeError(console.error(f"{response}: {response.reason}"))

        return response.json()

    @cached_property
    def download_url(self) -> str:
        browser_download_urls: list[str] = cast(
            list[str],
            [assets["browser_download_url"] for assets in self.info["assets"]],
        )
        matched_urls: list[str] = list(
            filter(
                lambda url: re.search(self._package_pattern, url) is not None,
                browser_download_urls,
            )
        )

        if len(matched_urls) == 1:
            return matched_urls[0]

        if len(matched_urls) == 0:
            messages: list[str] = [
                "matching url is not found",
                f"pattern: '{self._package_pattern}'",
                f"browser_download_urls: {browser_download_urls}",
            ]
        elif len(matched_urls) > 1:
            messages = [
                "multiple matching urls are found",
                f"pattern: '{self._package_pattern}'",
                f"browser_download_urls: {browser_download_urls}",
            ]
        raise AttributeError(console.error("\n".join(messages)))

    @cached_property
    def version(self) -> str:
        version = _get_github_package_version(self.download_url)
        if version is None:
            raise AttributeError(
                console.error(f"version not found in '{self.download_url}'")
            )
        return version

    def download_and_install(self):
        with tempfile.TemporaryDirectory() as tempdir:
            Path(tempdir).chmod(0o0777)
            with requests.get(self.download_url, stream=True) as response:
                content_disposition = response.headers["content-disposition"]
                filename = re.findall("filename=(.+)", content_disposition)[0]
                output = Path(tempdir) / filename
                with open(output, "wb") as f:
                    shutil.copyfileobj(response.raw, f)

            try:
                shutil.unpack_archive(output, extract_dir=tempdir)
            except shutil.ReadError:
                output = output.rename(output.with_name(self.bin))

            binary = [
                binary
                for binary in output.parent.glob(f"**/{self.bin}")
                if binary.is_file()
            ]
            assert len(binary) == 1
            binary_path = Path(binary[0])
            binary_path.chmod(stat.S_IXUSR)

            dest_path = Path.home() / ".local" / "bin" / binary_path.name

            shutil.move(binary_path, dest_path)
