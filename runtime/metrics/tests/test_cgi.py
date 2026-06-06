from runtime.metrics.services.cgi_engine import compute_cgi

score = compute_cgi(
    0.85,
    0.80,
    0.90,
    0.10,
    0.88,
    0.84
)

assert score >= 0.75
print("CGI_TEST_PASS")
