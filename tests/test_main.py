from fastapi.testclient import TestClient

from main import app

client = TestClient(app)


def test_home():
    response = client.get("/", headers={"content-type": "text/html; charset=utf-8"})
    assert response.status_code == 200
    assert b"Welcome to Wtf Website" in response.content
    response = client.get("/static/css/sticky-footer-navbar.css")
    assert response.status_code == 200
    response = client.get("/static/css/wtf-web-site.css")
    assert response.status_code == 200


def test_page_about():
    response = client.get(
        "/page/about",
        headers={"content-type": "text/html; charset=utf-8"},
    )
    assert response.status_code == 200
    assert b"About" in response.content
