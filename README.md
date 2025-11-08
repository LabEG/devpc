# DevPC - Containerized Development Environment

A fully-featured Docker image providing a complete desktop development environment for C# and TypeScript applications. This container includes a minimal desktop interface accessible via VNC, pre-configured with essential development tools.

## Features

### Included Software

- **Operating System**: Fedora Minimal
- **Desktop Environment**: LXQt with OpenBox window manager
- **Remote Access**: TigerVNC Server
- **Development Tools**:
  - .NET SDK
  - Visual Studio Code (with C# and TypeScript extensions)
  - Node.js with TypeScript and npm-check-updates
  - Git version control
- **Web Browser**: Falcon Browser

### Automatic Updates

The image is automatically rebuilt daily at midnight GMT to ensure the latest security patches and software updates.

> **Note**: You can install additional software as needed within the container.

![Docker LXQt Desktop via VNC Client](https://raw.githubusercontent.com/LabEG/devpc/master/.pics/vnc_container_view.png)

## Quick Start

### Evaluation Mode

To quickly test the environment without persistence:

```bash
docker run -it --rm -e password='YOUR_VNC_PASSWORD' -p 5901:5901 labeg/devpc
```

### Production Mode

For regular use with automatic restart:

```bash
docker run -d --restart always -e password='YOUR_VNC_PASSWORD' -p 5901:5901 labeg/devpc
```

After starting the container, connect using any VNC client at `localhost:5901` with your specified password.

## Configuration

### Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `password` | **Yes** | - | VNC connection password |
| `user_password` | No | `password` | Password for the `headless` user |
| `root_password` | No | `user_password` | Password for the `root` user |
| `resolution` | No | `1280x1024` | Virtual screen resolution (e.g., `1920x1080`) |

### Docker Options

| Option | Purpose |
|--------|---------|
| `--shm-size='64m'` | Increase shared memory size if browsers crash |
| `-p 5901:5901` | Expose VNC port |
| `--restart always` | Auto-restart container on failure |

## Customization

### Changing the LXQt Theme

1. Open Menu → Preferences → Appearance → LXQt Theme
2. Select your preferred theme (e.g., Kde-Plasma)

### Changing the OpenBox Theme

1. Open Menu → Preferences → LXQt Settings → OpenBox Settings
2. Select your preferred theme (e.g., Clearlooks)

## Building from Source

To build the image locally:

```bash
docker build -t labeg/devpc .
```

## Repository

Source code: [https://github.com/LabEG/devpc](https://github.com/LabEG/devpc)

## License

See [LICENSE](LICENSE) file for details.
