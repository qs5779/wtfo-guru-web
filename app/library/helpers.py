from pathlib import Path

import markdown


def openfile(filename: str) -> dict[str, str]:
    """Return dictionary with key text equal to html for page."""
    filepath = Path("app/pages") / filename
    with open(filepath, "r", encoding="utf-8") as input_file:
        text = input_file.read()

    title = filepath.name.replace(".md", "").capitalize()
    html = markdown.markdown(text, extensions=["fenced_code"])
    return {"text": html, "title": title}
