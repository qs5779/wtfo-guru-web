import re
import sys
from datetime import datetime
from pathlib import Path

import markdown
from loguru import logger


def openfile(filename: str) -> dict[str, str]:
    """Return dictionary with key text equal to html for page."""
    filepath = Path("app/pages") / filename
    with open(filepath, "r", encoding="utf-8") as input_file:
        text = input_file.read()

    mt = datetime.fromtimestamp(filepath.stat().st_mtime).strftime("%m/%d/%Y %H:%M:%S")
    title = filepath.name.replace(".md", "").capitalize()
    html = markdown.markdown(text, extensions=["fenced_code"])
    match = re.match(r"([^(]+)", sys.version)
    if match:
        version = match[1].strip()
    else:
        version = "unknown"
    logger.debug("retruning data for: {0}".format(str(filepath)))
    return {"text": html, "title": title, "version": version, "updated": mt}
