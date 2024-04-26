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

    fruit = {"text": markdown.markdown(text, extensions=["fenced_code"])}
    fruit["title"] = filepath.name.replace(".md", "").capitalize()
    fruit["updated"] = datetime.fromtimestamp(filepath.stat().st_mtime).strftime(
        "%m/%d/%Y %H:%M:%S",
    )
    match = re.match("([^(]+)", sys.version)
    if match:
        fruit["version"] = match[1].strip()
    else:
        fruit["version"] = "unknown"
    logger.debug("returning data for: {0}".format(str(filepath)))
    return fruit
