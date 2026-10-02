c = get_config()
c.VoilaConfiguration.preheat_kernel = False
c.VoilaConfiguration.show_tracebacks = True
c.VoilaExecutor.timeout = 1800

# Permit the authenticated Codespaces editor to embed its own notebook.
import os
if os.environ.get("CODESPACES") == "true" and os.environ.get("CODESPACE_NAME"):
    editor_origin = "https://" + os.environ["CODESPACE_NAME"] + ".github.dev"
    c.ServerApp.tornado_settings = {
        "headers": {"Content-Security-Policy": "frame-ancestors 'self' " + editor_origin}
    }
